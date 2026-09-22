#!/bin/zsh

set -e

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOME="/Users/peterpopescu"
export SECRET_UUID="de522d17-3847-4643-8869-b4cc01292cb2"
export BORG_PASSCOMMAND="$HOME/.local/bin/bws-auth secret get $SECRET_UUID --output json | /usr/bin/python3 -c 'import json,sys; print(json.load(sys.stdin)[\"value\"])'"

REPO="peter@nas-ty:/mnt/hdd/backups/borg/mac"

SOURCES=(
    "$HOME/Documents"
    "$HOME/classes"
)

if [[ "${1:-}" == "--iphone" ]]; then
    SOURCES+=("$HOME/Library/Application Support/MobileSync/Backup")
    ARCHIVE_PREFIX="mac-iphone"
elif [[ -n "${1:-}" ]]; then
    echo "Usage: $0 [--iphone]" >&2
    exit 2
else
    ARCHIVE_PREFIX="mac"
fi

echo "Starting Borg backup: $(date)"

borg create \
    --stats \
    --exclude-from="$HOME/.config/borg/excludes" \
    "$REPO::${ARCHIVE_PREFIX}-{now}" \
    "${SOURCES[@]}"

echo "Pruning regular Mac archives..."

borg prune \
    --list \
    --glob-archives='mac-[0-9]*' \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=12 \
    "$REPO"

echo "Pruning iPhone archives..."

borg prune \
    --list \
    --glob-archives='mac-iphone-*' \
    --keep-monthly=12 \
    "$REPO"

echo "Backup complete: $(date)"

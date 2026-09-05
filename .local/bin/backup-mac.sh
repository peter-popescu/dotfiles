#!/bin/zsh

set -e

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOME="/Users/peterpopescu"
export BORG_PASSCOMMAND='security find-generic-password -a "peterpopescu" -s "borg-mac-backup" -w'

REPO="peter@nas-ty:/mnt/hdd/backups/borg/mac"

echo "Starting Borg backup: $(date)"

borg create \
    --stats \
    --exclude-from="$HOME/.config/borg/excludes" \
    "$REPO::mac-{now}" \
    "$HOME/Documents" \
    "$HOME/classes"

echo "Pruning old archives..."

borg prune \
    --list \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=12 \
    "$REPO"

echo "Backup complete: $(date)"

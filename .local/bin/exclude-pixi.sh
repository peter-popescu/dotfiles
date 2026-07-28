#!/bin/bash

# Make sure we are actually inside a git repo first
if [ ! -d ".git" ]; then
    echo "No .git directory found here. Task aborted."
    exit 1
fi

EXCLUDE_FILE=".git/info/exclude"
EXCLUDES=(".pixi/" "pixi.toml" "pixi.lock" ".gitattributes")

echo "Updating $EXCLUDE_FILE..."

# Loop through and append if they aren't already there
for entry in "${EXCLUDES[@]}"; do
    if ! grep -Fxq "$entry" "$EXCLUDE_FILE"; then
        echo "$entry" >> "$EXCLUDE_FILE"
        echo "  + Added $entry"
    else
        echo "  ~ $entry already excluded"
    fi
done

echo "Done."

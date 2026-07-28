#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # The subshell (...) runs both commands and pipes all output directly to fzf
    selected=$( (find ~/code ~/classes -maxdepth 1 -type d 2>/dev/null;
        echo "$HOME/.config";
        echo "$HOME/.config/spotatui") | fzf )
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

# Sanitize the name so tmux doesn't freak out over dots or colons
selected_name=$(basename "$selected" | tr ' .:' '___')

tmux_running=$(pgrep tmux)

# If the tmux server isn't running at all, start it
if [[ -z "$TMUX" ]] && [[ -z "$tmux_running" ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

# If the specific session doesn't exist yet, create it in the background
if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Switch to the session
tmux switch-client -t "$selected_name"

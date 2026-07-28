#!/bin/bash

# Kill all numbered tmux sessions
tmux list-sessions -F "#{session_name}" | while read -r session; do
  if [[ "$session" =~ ^[0-9]+$ ]]; then
    echo "Killing session: $session"
    tmux kill-session -t "$session"
  fi
done

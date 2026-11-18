#!/bin/bash

STATE_FILE="$HOME/.local/state/display-mode"

mode="work"
if [ -f "$STATE_FILE" ]; then
    mode=$(cat "$STATE_FILE")
fi

if [ "$mode" = "game" ]; then
    echo '{"text": "75Hz", "tooltip": "Gaming Mode: 1080p @ 75Hz\nClick to switch to Work Mode (2K)"}'
else
    echo '{"text": "2K", "tooltip": "Work Mode: 2560x1440 @ 60Hz\nClick to switch to Gaming Mode (75Hz)"}'
fi

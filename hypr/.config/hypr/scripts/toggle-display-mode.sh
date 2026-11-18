#!/bin/bash

STATE_FILE="$HOME/.local/state/display-mode"
MONITORS_CONF="$HOME/.config/hypr/monitors.conf"

current_mode="work"
if [ -f "$STATE_FILE" ]; then
    current_mode=$(cat "$STATE_FILE")
fi

mkdir -p "$HOME/.local/state"

if [ "$current_mode" = "work" ]; then
    # Switch to Gaming Mode (1080p @ 75Hz)
    hyprctl keyword monitor "HDMI-A-1, 1920x1080@75, 0x0, 1"
    hyprctl keyword monitor "eDP-1, 1366x768@60, 1920x0, 1"
    sed -i 's/monitor = HDMI-A-1, 2560x1440@60, 0x0, 1/monitor = HDMI-A-1, 1920x1080@75, 0x0, 1/' "$MONITORS_CONF"
    sed -i 's/monitor = eDP-1, 1366x768@60, 2560x0, 1/monitor = eDP-1, 1366x768@60, 1920x0, 1/' "$MONITORS_CONF"
    echo "game" > "$STATE_FILE"
    notify-send -u low "Display Mode" "Gaming Mode Active (1080p @ 75Hz)"
else
    # Switch to Work Mode (1440p @ 60Hz)
    hyprctl keyword monitor "HDMI-A-1, 2560x1440@60, 0x0, 1"
    hyprctl keyword monitor "eDP-1, 1366x768@60, 2560x0, 1"
    sed -i 's/monitor = HDMI-A-1, 1920x1080@75, 0x0, 1/monitor = HDMI-A-1, 2560x1440@60, 0x0, 1/' "$MONITORS_CONF"
    sed -i 's/monitor = eDP-1, 1366x768@60, 1920x0, 1/monitor = eDP-1, 1366x768@60, 2560x0, 1/' "$MONITORS_CONF"
    echo "work" > "$STATE_FILE"
    notify-send -u low "Display Mode" "Work Mode Active (1440p @ 60Hz)"
fi

pkill -RTMIN+11 waybar 2>/dev/null || true

if systemctl --user is-active --quiet mpvpaper 2>/dev/null; then
    "$HOME/.config/hypr/scripts/livewallpaper.sh" restart >/dev/null 2>&1 &
fi

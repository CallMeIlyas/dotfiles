#!/usr/bin/env bash

# Pastikan monitor eksternal terdeteksi
EXTERNAL=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.name | test("^(eDP|LVDS|DSI)-") | not).name' | head -n 1)
INTERNAL="eDP-1"

if [ -n "$EXTERNAL" ]; then
    # Pindahkan workspace 1-5 ke monitor eksternal
    for ws in 1 2 3 4 5; do
        hyprctl dispatch "hl.dsp.workspace.move({ workspace = '$ws', monitor = '$EXTERNAL' })" >/dev/null 2>&1 || true
    done

    # Pindahkan workspace 6-10 ke monitor laptop
    for ws in 6 7 8 9 10; do
        hyprctl dispatch "hl.dsp.workspace.move({ workspace = '$ws', monitor = '$INTERNAL' })" >/dev/null 2>&1 || true
    done

    # Fokuskan workspace default
    hyprctl dispatch "hl.dsp.focus({ monitor = '$INTERNAL' })" >/dev/null 2>&1
    hyprctl dispatch "hl.dsp.focus({ workspace = '6' })" >/dev/null 2>&1
    hyprctl dispatch "hl.dsp.focus({ monitor = '$EXTERNAL' })" >/dev/null 2>&1
    hyprctl dispatch "hl.dsp.focus({ workspace = '1' })" >/dev/null 2>&1
fi

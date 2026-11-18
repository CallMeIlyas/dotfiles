#!/bin/bash
STATE_FILE="$HOME/.local/state/omarchy/toggles/hypr/window-no-gaps-custom.lua"
if [[ -f "$STATE_FILE" ]]; then
  rm -f "$STATE_FILE"
else
  mkdir -p "$(dirname "$STATE_FILE")"
  cat > "$STATE_FILE" << 'INNER'
-- Remove gaps & border only. Rounding is intentionally NOT touched here.
hl.config({
  general = {
    gaps_out = 0,
    gaps_in = 0,
    border_size = 0,
  },
})
INNER
fi
hyprctl reload >/dev/null

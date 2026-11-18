#!/usr/bin/env bash
MONITORS_LUA="$HOME/.config/hypr/monitors.lua"

case "$1" in
  get)
    if hyprctl monitors 2>/dev/null | grep -q "2560x1440"; then
      echo "2k"
    elif hyprctl monitors 2>/dev/null | grep -q "1920x1080"; then
      echo "1080p"
    else
      echo "2k"
    fi
    ;;
  set)
    MODE="$2"
    if [ "$MODE" = "2k" ]; then
      cat << 'EOF' > "$MONITORS_LUA"
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Monitor eksternal (Kiri - 2K 60Hz)
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@60", position = "0x0", scale = 1 })

-- Layar laptop (Kanan)
hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "2560x0", scale = 1 })

-- Fallback default
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Workspace bindings: Monitor Eksternal (1-5), Layar Laptop (6-10)
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })

hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
EOF
    elif [ "$MODE" = "1080p" ]; then
      cat << 'EOF' > "$MONITORS_LUA"
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Monitor eksternal (Kiri - 1080p 75Hz)
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@75", position = "0x0", scale = 1 })

-- Layar laptop (Kanan)
hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "1920x0", scale = 1 })

-- Fallback default
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Workspace bindings: Monitor Eksternal (1-5), Layar Laptop (6-10)
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })

hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
EOF
    fi
    hyprctl reload
    ;;
esac

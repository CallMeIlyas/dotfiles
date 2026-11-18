-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.
-- See current bindings and descriptions:
--   omarchy menu keybindings --print
-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false
-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Toggle window gaps & borders only (rounding stays permanently on)
hl.unbind("SUPER + SHIFT + BACKSPACE")
o.bind(
	"SUPER + SHIFT + BACKSPACE",
	"Toggle gaps (rounding stays on)",
	"~/.config/hypr/scripts/toggle-gaps-keep-rounding.sh"
)

-- Browser overrides (Flatpak Brave)
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Browser", "uwsm-app -- flatpak run com.brave.Browser")

hl.unbind("SUPER + SHIFT + RETURN")
o.bind("SUPER + SHIFT + RETURN", "Browser", "uwsm-app -- flatpak run com.brave.Browser")

hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", "uwsm-app -- flatpak run com.brave.Browser --incognito")

-- YouTube override (Flatpak Brave with adblock)
hl.unbind("SUPER + SHIFT + Y")
o.bind("SUPER + SHIFT + Y", "YouTube", "uwsm-app -- flatpak run com.brave.Browser --app=https://youtube.com/")

-- Calculator override (Qalculate!)
hl.unbind("SUPER + CTRL + Q")
o.bind("SUPER + CTRL + Q", "Calculator", { launch = "qalculate-gtk" })


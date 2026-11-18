-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 2,
  },

  decoration = {
    rounding = 20,
  },
})

-- Enable smooth window and workspace switching animations
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.8, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.8, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "almostLinear" })

-- Opt another application in to Omarchy's standard transparency.
-- Find its class with: hyprctl clients
-- o.transparent_window("my-app")
-- o.transparent_window("my-app", "0.9 0.85") -- Custom active/inactive opacity.

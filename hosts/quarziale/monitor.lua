hl.monitor({
    output   = "HDMI-A-2",
    mode     = "3840x2160@120",
    position = "0x0",
    scale    = "1.25",
    bitdepth = 10,
    cm = "hdr",
    vrr = 2,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "2560x1440@120",
    position = "auto-center-right",
    scale    = "1.25",
    transform = 3,
})

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

-- Make HDMI-A-2 the primary output for XWayland apps.
hl.on("hyprland.start", function()
    hl.exec_cmd("xrandr --output HDMI-A-2 --primary")
end)

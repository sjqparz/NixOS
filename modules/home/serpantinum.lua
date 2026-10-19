local function shell(cmd)
  return hl.dsp.exec_cmd("serpantinum " .. cmd)
end

hl.bind("SUPER + SPACE",     shell("msg toggle launcher"))
hl.bind("SUPER + V",         shell("msg toggle clipboard"))
hl.bind("SUPER + L",         shell("lock"))
hl.bind("SUPER + SHIFT + S", shell("screenshot"))
hl.bind("SUPER + SHIFT + R", shell("reload"))
hl.bind("SUPER + P",         shell("msg toggle wallpaper"))

-- Workspace switching goes through the shell so the bar indicators update
--[[ for i = 1, 10 do
  hl.bind("SUPER + " .. (i % 10), shell("msg workspace " .. i))
  hl.bind("SUPER + SHIFT + " .. (i % 10), shell("msg workspace " .. i .. " move"))
end ]]
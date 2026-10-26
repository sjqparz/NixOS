{ pkgs, inputs, username, ... }:
{
  
  /* services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/sean";
  }; */

  home-manager.users.${username} = {
    imports = [ inputs.dms.homeModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      enableSystemMonitoring = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
    };

    wayland.windowManager.hyprland.extraConfig = ''
      local ipc = "dms ipc call "

      hl.on("hyprland.start", function()
        hl.exec_cmd("dms run")
      end)

      hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
      hl.bind(mainMod .. " + Z",         hl.dsp.exec_cmd("dms ipc call control-center toggle"))
      hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("dms ipc wallpaperCarousel toggle"))
    '';

  };

}
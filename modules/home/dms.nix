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
  };

}
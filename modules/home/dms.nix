{ pkgs, inputs, username, ... }:
{
  
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
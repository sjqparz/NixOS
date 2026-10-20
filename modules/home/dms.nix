{ pkgs, inputs, ... }:
{

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
  };

  home-manager.users.${username} = {
    imports = [ inputs.dms.homeModules.dank-material-shell ];
    };

}
{ pkgs, inputs, ... }:

let

  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves";
  };

in 
{

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = false;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [ 
        astronaut
      ]; 
    };

    autoLogin = {
      enable = true;
      user = "sean";
    };
  };

  services.xserver.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xrandr}/bin/xrandr --output HDMI-A-1 --off --output HDMI-A-2 --auto --primary
  ''; 

  environment.systemPackages = [ astronaut ];
}
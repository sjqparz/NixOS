{ pkgs, config, lib, ... }:

let
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves";
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [ 
      astronaut
      #kdePackages.qtmultimedia #Required for video 
    ];
  };

  services.xserver.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xrandr}/bin/xrandr --output HDMI-A-1 --off --output HDMI-A-2 --auto --primary
  '';

  /* autoLogin = {
    enable = true;
    user = "sean";
  }; */

  services.displayManager.defaultSession = "hyprland";

  environment.systemPackages = [ astronaut ];
}


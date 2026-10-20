{ pkgs, ... }:

let
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "japanese_aesthetic";
#    themeConfig = {
#        Background = "${./grid2.jpeg}";
#    };
  };
in
{
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr \
      --output HDMI-A-2 --primary --auto \
      --output HDMI-A-1 --off
  '';

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [ 
      astronaut
      kdePackages.qtmultimedia #Required for video 
    ];
  };

   environment.systemPackages = [ astronaut ];
}


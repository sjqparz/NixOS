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
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ astronaut ];
  };

  environment.systemPackages = [ astronaut ];
}

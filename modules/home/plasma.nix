# Plasma: system-level (NixOS) and user-level (home-manager / plasma-manager).
{ pkgs, username, ... }:

{
  # ---------- System level (NixOS) ----------
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    elisa
    okular
    khelpcenter
    baloo
    qrca
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ---------- User level (home-manager) ----------
  home-manager.users.${username} = { pkgs, ... }: {
    programs.plasma = {
      enable = true;
      panels = [
        {
          location = "bottom";
          height = 52;
          floating = true;
          hiding = "autohide";
          alignment = "center";
          lengthMode = "fit";
        }
      ];
      workspace = {
        colorScheme = "CatppuccinMochaLavender";
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
        windowDecorations = {
          library = "org.kde.breeze";
          theme = "Breeze";
        };
        splashScreen.theme = "None";
        iconTheme = "Papirus-Dark"; # merged in from the separate line
      };
    };

    home.packages = [
      (pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "lavender" ];
        winDecStyles = [ "classic" ];
      })
    ];
  };
}

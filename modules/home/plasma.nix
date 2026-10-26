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
    gwenview
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
        iconTheme = "YAMIS"; # merged in from the separate line
      };
    };

    home.packages = [
      (pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "lavender" ];
        winDecStyles = [ "classic" ];
      })
    ];

#    home.pointerCursor = {
#      package = pkgs.bibata-cursors;
#      name = "Bibata-Modern-Ice";
#      size = 24;
#      gtk.enable = true;
#      x11.enable = true;
#    };

#    xdg.dataFile."icons/YAMIS".source = builtins.fetchGit {
#      url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
#      rev = "367da5db6c03ac581e7105da071f2b961d587a2a";
#    };
  };
}

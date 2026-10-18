{ pkgs, username, inputs, ... }:

{
  # ---------- System level (NixOS) ----------
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
  };

  hardware.graphics = {
    package = pkgs.unstable.mesa;
    package32 = pkgs.unstable.pkgsi686Linux.mesa;
  };

  programs.dconf.enable = true;
  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    adw-gtk3
    nwg-look
    #papirus-icon-theme
  ];

  # Pre-built Noctalia binaries, so it isn't compiled locally. Only works while
  # the noctalia flake input does NOT use `inputs.nixpkgs.follows`.
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  # ---------- User level (Home Manager) ----------
  home-manager.users.${username} = {
    #imports = [ inputs.noctalia.homeModules.default ];

     programs.noctalia = {
      enable = true;
      settings = {
        theme.templates = {
          enable.builtin_templates = true;
          builtins_ids = [ "hyprland" ];
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      #Null avoids conflict with programs.hyprland.enable above
      package = null;
      portalPackage = null;

      configType = "lua";
      extraConfig = builtins.readFile ./hyprland.lua;
    };

    home.packages = with pkgs; [
      playerctl           # media keys        (XF86Audio*)
      xrandr              # autostart: `xrandr --output HDMI-A-2 --primary`
      quickshell          
    ];
  };
}

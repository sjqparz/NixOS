{ pkgs, username, inputs, ... }:

{
  # ---------- System level (NixOS) ----------
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    withUWSM = false;
  };

  programs.dconf.enable = true;
  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    adw-gtk3
    nwg-look
    papirus-icon-theme
  ];

  # ---------- User level (Home Manager) ----------
  home-manager.users.${username} = {

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

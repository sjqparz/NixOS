# Serpantinum shell: system prerequisites, Home Manager config, Hyprland binds.
{ inputs, username, ... }:

{
  imports = [ inputs.serpantinum.nixosModules.default ];

  # ---------- System level (NixOS) ----------
  programs.serpantinum.enable = true;

  # ---------- User level (Home Manager) ----------
  home-manager.users.${username} = { config, ... }: {
    imports = [ inputs.serpantinum.homeManagerModules.default ];

    programs.serpantinum = {
      enable = true;
      systemd.enable = true;
      settings = {
        wallpaperDir = "${config.home.homeDirectory}/.config/nixos/modules/home/wallpaper";
        general.language = "en";
        bar = {
          position = "top";
          modules = {
            left = [ "workspaces" ];
            center = [ "time" ];
            right = [ "tray" [ "kb" "wifi" "bt" "vol" "bat" ] ];
          };
        };
        theme.fontFamily = "Adwaita Mono";
      };
    };

    # Written to ~/.config/hypr/serpantinum.lua and require()'d automatically
    wayland.windowManager.hyprland.extraLuaFiles.serpantinum = {
      content = ./serpantinum.lua;
      autoLoad = true;
    };
  };
}
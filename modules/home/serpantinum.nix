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
      systemd.enable = false;
      settings = {
        wallpaperDir = "/home/sean/.config/nixos/modules/home/wallpaper";
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

    wayland.windowManager.hyprland.extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd("systemctl --user enable --now easyeffects")
        hl.exec_cmd("serpantinumd start")
      end)

      hl.bind("SUPER + SPACE",     hl.dsp.exec_cmd("msg toggle launcher"))
      hl.bind("SUPER + V",         hl.dsp.exec_cmd("msg toggle clipboard"))
      hl.bind("SUPER + L",         hl.dsp.exec_cmd("lock"))
      hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("screenshot"))
      hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("reload"))
      hl.bind("SUPER + P",         hl.dsp.exec_cmd("msg toggle wallpaper"))
    '';

  };
}
{ pkgs, inputs, username, ... }:
{  
  
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  
  # Pre-built Noctalia binaries, so it isn't compiled locally. Only works while
  # the noctalia flake input does NOT use `inputs.nixpkgs.follows`.
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  home-manager.users.${username} = {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia = {
      enable = true;
      settings = {
        theme.templates = {
          enable.builtin_templates = true;
          builtins_ids = [ "hyprland" ];
        };
      wallpaper = {
          enabled = true;
          default.path = "/home/sean/.config/nixos/home/wallpaper";
        };
      };
    };

    wayland.windowManager.hyprland.extraConfig = ''
      local ipc = "noctalia msg "
      
      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia")
      end)

      hl.bind(mainMod .. " + SPACE",      hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
      hl.bind(mainMod .. " + Z",          hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
      hl.bind(mainMod .. " + P",          hl.dsp.exec_cmd("noctalia msg panel-toggle ashur-d/wallpaper-widget:hub"))
    '';

  };

}
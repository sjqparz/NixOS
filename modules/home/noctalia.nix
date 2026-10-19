{ inputs, username, ... }:
{  
  
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
  };

}
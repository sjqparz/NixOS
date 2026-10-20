{ pkgs, inputs, username, ... }:
{ 

  home-manager.users.${username} = {
    imports = [ inputs.caelestia-shell.homeManagerModules.default ];
    programs.caelestia = {
        enable = true;
        cli.enable = true;
    };
  };

}
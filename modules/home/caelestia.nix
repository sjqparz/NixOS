{ pkgs, inputs, ... }:
{ 

  home-manager.users.${username} = {
    imports = [ inputs.caelestia.homeManagerModules.default ];
    programs.caelestia = {
        enable = true;
        cli.enable = true;
    };
  };

}
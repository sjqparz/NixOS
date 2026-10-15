# Wires Home Manager and plasma-manager into the system. It does not say what each user gets; each host's default.nix does that.
{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;           # one shared nixpkgs; allowUnfree etc. are set on the NixOS side
    useUserPackages = true;
    backupFileExtension = "backup"; # move aside existing dotfiles instead of failing
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
  };
}

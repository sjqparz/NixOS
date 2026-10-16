{
  #Nix packages
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    #Home manager + Plasma manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    #Noctalia + Plugins
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      # Defined once; any module can ask for `username` as an argument.
      username = "sean";

      # Each machine's real configuration lives in hosts/<name>/default.nix
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
        modules = [ ./hosts/${hostname} ];
      };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";
        vm = mkHost "vm";
      };
    };
}

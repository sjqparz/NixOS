{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    serpantinum.url = "github:ilyamiro/serpantinum";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable"
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let

      username = "sean";
      system = "x86_64-linux";

      mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username hostname; };
        modules = [
          { nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = final.stdenv.hostPlatform.system;
                config.allowUnfree = true;
              };
            })
         ];} 
          ./modules/system/base.nix
          ./hosts/${hostname}
          { networking.hostName = hostname; }
        ];
      };
    in
    {
      nixosConfigurations = {
        quarziale = mkHost "quarziale";
        framework = mkHost "framework";
        vm        = mkHost "vm";
      };
    };
}

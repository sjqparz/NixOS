{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      # Defined once; any module can ask for `username` as an argument.
      username = "sean";
      system = "x86_64-linux";

      # Each machine's real configuration lives in hosts/<name>/default.nix
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
          ];
        } 
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
        vm = mkHost "vm";
      };
    };
}

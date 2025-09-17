{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
	  };
    nvf = {
      url = "github:notashelf/nvf";
    };

  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
    hostname = "nixos";
    username = "mugahed";
  in {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit hostname;
          profile = "thinkpad";
          inherit username;
          inherit home-manager;
        };
        modules = [
          ./profiles/thinkpad
        ];
      };
      };
    };
}

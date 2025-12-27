{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rustpkg = {
      url = "github:nixos/nixpkgs/306ea70f9eb0fb4e040f8540e2deab32ed7e2055";
    };
    rustdeskServerpkg = {
      url = "github:nixos/nixpkgs/ee09932cedcef15aaf476f9343d1dea2cb77e261";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:mugaizzo/nvf/option/vimtex";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
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

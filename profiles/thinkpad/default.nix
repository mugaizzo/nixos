{username, ...}: {
  imports = [
    ./hardware-configuration.nix
    #    ../../modules/drivers
    ../../modules/core
    ./configuration.nix
  ];
}

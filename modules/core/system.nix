{ inputs, ... }:
{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  time.timeZone = "America/Denver";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  #  system.autoUpgrade = {
  #    enable = true;
  #    flake = inputs.self.outPath;
  #    flags = ["-L"];
  #    dates = "02:00";
  #    randomizedDelaySec = "45m";
  #  };

  nix.optimise = {
    automatic = true;
    dates = "02:15";
  };

  nix.gc = {
    automatic = true;
    dates = "02:30";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.05"; # Do not change
}

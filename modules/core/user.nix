{
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username;};

    users.${username} = {
      # Allow unfree packages across the entire system
      nixpkgs.config.allowUnfree = true;

      imports = [
        ./../home
      ];

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.05"; # Do not change
        sessionVariables = {
          EDITOR = "nvim";
          MANPAGER = "nvim -c 'Man! -'";
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$JqPRec7d2TA8bzEr$hkeQvoM0qEdUPU4chLV5b.nDvTHk6ndJlib9DeFssVc.i3jnCDnoL6hSZ/z6sIuNRRinK/S6CFE1cWaD2BS/U.";
    description = "mugahed";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #  thunderbird
      firefox

      btop
      vscode
      git
      wget
      tree
      yazi
      lazygit
      racket
      slack
      kdePackages.konsole
      zoom-us

      brightnessctl
      playerctl
      flameshot
      i3lock
      emote
      xbindkeys
      rofi
      jq
      feh
      autorandr
      bc
      arandr
      nil
      blueman
      networkmanagerapplet

      picom
      dex
      xss-lock
      polybar
      killall
      openvpn
      pwvucontrol
      oranchelo-icon-theme
      # inputs.rustpkg.legacyPackages.${system}.rustdesk
      # inputs.rustdeskServerpkg.legacyPackages.${system}.rustdesk-server
      zathura
      ripgrep
      texliveFull

      zsh
    ];
  };
}

{
  pkgs,
  inputs,
  username,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;

  # Import the pinned nixpkgs with allowUnfree config
  # rustPinnedPkgs = import inputs.rustpkg {
  #   inherit system;
  #   config.allowUnfree = true;
  # };

  # rustdeskServerPinnedPkgs = import inputs.rustdeskServerpkg {
  #   inherit system;
  #   config.allowUnfree = true;
  # };

  # polybarPinnedPkg = import inputs. polybarpkg {
  #   inherit system;
  #   config. allowUnfree = true;
  # };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs username; };

    users.${username} = {
      # Allow unfree packages across the entire system
      nixpkgs.config.allowUnfree = true;

      imports = [
        inputs.nixvim.homeModules.default
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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # General packages
      #  thunderbird
      firefox
      btop
      # vscode
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
      emote
      rofi
      bc
      blueman
      networkmanagerapplet
      dex
      killall
      openvpn
      pwvucontrol
      oranchelo-icon-theme
      # rustPinnedPkgs.rustdesk
      # rustdeskServerPinnedPkgs.rustdesk-server
      rustdesk
      rustdesk-server
      zathura
      ripgrep
      texliveFull
      syncthing
      obsidian
      zotero
      discord
      opencode
      claude-code
      pywalfox-native

      # i3
      flameshot
      i3lock-fancy
      xbindkeys
      jq
      feh
      autorandr
      arandr
      polybar
      picom
      xss-lock
      redshift
      xclip

      # sway specific packages
      wdisplays
      cliphist
      wl-clipboard
      sov
      input-remapper
    ];
  };
}

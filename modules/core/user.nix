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
      };
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$JqPRec7d2TA8bzEr$hkeQvoM0qEdUPU4chLV5b.nDvTHk6ndJlib9DeFssVc.i3jnCDnoL6hSZ/z6sIuNRRinK/S6CFE1cWaD2BS/U.";
    description = "mugahed";
    extraGroups = [ "networkmanager" "wheel" ];
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
    ];
  };
}

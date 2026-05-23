{ username, pkgs, ... }:
{
  # Automount usb drives
  # systemd.tmpfiles.rules = [
  #   "d /run/media/${username} 0755 ${username} ${username} -"
  # ];

  services = {
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    }; # Mouse
    # fstrim.enable = true; # Trim SSD
    # udisks2.enable = true; # Mount usb drives
    # gvfs.enable = true; # Mount usb drives
    # tumbler.enable = true; # Image/Video preview
    # gnome.gnome-keyring.enable = true; # Store system credentials
    # smartd.enable = true; # Check disks health
    # thermald.enable = true; # Monitor CPU temperature
    # tlp.enable = true; # Power saving
    # jitterentropy-rngd.enable = true; # Better entropy

    logind.settings.Login.HandleLidSwitch = "ignore"; # Ignore when the lid is closed -> Hypridle etc. handles suspending
    power-profiles-daemon.enable = true;
    fprintd.enable = true;
    rustdesk-server = {
      enable = true;
      signal = {
        enable = true;
        relayHosts = [ "192.168.1.61" ];
        #        extraArgs = ["-k" "/home/mugahed/.ssh/id_ed25519_rustdesk"];
      };
      relay = {
        enable = true;
        # extraArgs = ["-k" "/home/mugahed/.ssh/id_ed25519_rustdesk"];
      };
      openFirewall = true;
    };

    # Enable audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # syncthing = {
    #   enable = true;
    #   openDefaultPorts = true;
    #   configDir = "/home/mugahed/.local/state/syncthing";
    # };
  };

  # Disable fingerprint on the login PAM service (used by TTY login).
  security.pam.services.login.fprintAuth = false;

  # For SDDM: try fingerprint first, fall back to password.
  # pam_fprintd is inserted as sufficient; if it fails/times out pam_unix catches it.
  security.pam.services.sddm.rules.auth = {
    fprintd = {
      order = 10;
      control = "sufficient";
      modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
    };
    unix = {
      order = 20;
      control = "sufficient";
      modulePath = "pam_unix.so";
      args = [ "likeauth" "nullok" "try_first_pass" ];
    };
    deny = {
      order = 30;
      control = "required";
      modulePath = "pam_deny.so";
    };
  };
}

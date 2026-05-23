{ username, pkgs, lib, ... }:
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

  # Fingerprint-first with password fallback for all PAM services.
  # Applied on the `login` service which sddm, sudo, and polkit all delegate to.
  # pam_fprintd: sufficient — success = authenticated, no-finger-enrolled or timeout = try next
  # pam_unix:    sufficient — success = authenticated, fail = try next
  # pam_deny:    required  — rejects if both above failed
  security.pam.services.login.rules.auth = {
    fprintd = {
      order = 10;
      control = "sufficient";
      modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
    };
    unix = {
      order = 20;
      control = lib.mkForce "sufficient";
      args = lib.mkForce [ "likeauth" "nullok" "try_first_pass" ];
    };
    deny.order = lib.mkForce 30;
  };

  # SDDM: use same auth as login (inherits the rule above via substack).
  # Remove any per-service override so sddm just delegates to login.
  security.pam.services.sddm.fprintAuth = false;
}

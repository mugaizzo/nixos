{username, ...}: {
  # Automount usb drives
  # systemd.tmpfiles.rules = [
  #   "d /run/media/${username} 0755 ${username} ${username} -"
  # ];

  services = {
    # libinput.enable = true; # Mouse
    # fstrim.enable = true; # Trim SSD
    # udisks2.enable = true; # Mount usb drives
    # gvfs.enable = true; # Mount usb drives
    # tumbler.enable = true; # Image/Video preview
    # gnome.gnome-keyring.enable = true; # Store system credentials
    # smartd.enable = true; # Check disks health
    # thermald.enable = true; # Monitor CPU temperature
    # tlp.enable = true; # Power saving
    # jitterentropy-rngd.enable = true; # Better entropy

    logind.HandleLidSwitch = "ignore"; # Ignore when the lid is closed -> Hypridle etc. handles suspending
    # Enable audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}

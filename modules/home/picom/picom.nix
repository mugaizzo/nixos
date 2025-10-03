{
  config,
  lib,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    settings = {
      # Corner settings
      corner-radius = 10;
      round-borders = 1;
      rounded-corners-exclude = [
        "class_g = 'Polybar'"
      ];

      # Animations
      # animations = [
      #   {
      #     triggers = ["close"];
      #     preset = "disappear";
      #   }
      #   {
      #     triggers = ["open"];
      #     preset = "appear";
      #   }
      # ];

      # Commented settings (uncomment if needed)
      # inactive-opacity = 0.8;
      # opacity-rule = [
      #   "100:class_g = 'Rofi'"
      # ];
      # frame-opacity = 1;
      # inactive-opacity-override = false;
      # fading = true;
      # no-fading-openclose = false;
      # fading-sync = true;
      # fading-frames = 10;
      # fading-delta = 4;
    };
  };
}

{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    i3.enable = lib.mkEnableOption "enable i3";
  };

  config = lib.mkIf config.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";

        # Fonts configuration
        fonts = {
          names = ["Noto Kufi Arabic"];
          size = 9.0;
        };

        # Terminal configuration
        terminal = "konsole";

        # Gaps configuration
        gaps = {
          inner = 10;
          outer = 5;
          smartGaps = true;
        };

        # Floating window mmodifier
        floating.modifier = "Mod4";

        # Allow window dragging
        focus.followMouse = true;

        # Workspace naming
        workspaceOutputAssign = [];

        # Custom keybindings
        keybindings = let
          inherit (config.xsession.windowManager.i3.config) modifier;
        in {
          # Kill focused window
          "${modifier}+q" = "kill";

          # # Launch app launcher
          # "${modifier}+d" = "exec --no-startup-id rofi -show run";

          # Focus window
          "${modifier}+j" = "focus left";
          "${modifier}+k" = "focus down";
          "${modifier}+l" = "focus up";
          "${modifier}+semicolon" = "focus right";

        };
      };
    };
  };
}

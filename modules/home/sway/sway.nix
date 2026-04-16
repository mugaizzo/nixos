{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sway.enable = lib.mkEnableOption "enable sway";
  };

  config = lib.mkIf config.sway.enable {
    home.packages = with pkgs; [
      # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      noctalia-shell
    ];
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec {
        input = {
          "type:touchpad" = {
            natural_scroll = "enable";
            tap = "enable";
            drag_lock = "disable";
            click_method = "clickfinger";
          };
        };

        modifier = "Mod4";

        bars = [ ];
        defaultWorkspace = "1";

        # Fonts configuration
        fonts = {
          names = [ "Noto Kufi Arabic" ];
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
        workspaceOutputAssign = [ ];

        # Custom keybindings
        keybindings = {
          # Launch terminal
          "${modifier}+Return" = "exec  konsole";

          # Kill focused window
          "${modifier}+q" = "kill";

          # Launch app launcher
          "${modifier}+d" = "exec rofi -show run";
          "${modifier}+c" = "exec rofi -show window";

          # Focus window
          "${modifier}+j" = "focus left";
          "${modifier}+k" = "focus down";
          "${modifier}+l" = "focus up";
          "${modifier}+semicolon" = "focus right";
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          # Move window
          "${modifier}+Shift+j" = "move left";
          "${modifier}+Shift+k" = "move down";
          "${modifier}+Shift+l" = "move up";
          "${modifier}+Shift+semicolon" = "move right";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Split direction
          "${modifier}+h" = "split h";
          "${modifier}+v" = "split v";

          # Fullscreen
          "${modifier}+f" = "fullscreen toggle";

          # Layout controls
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+Shift+x" = "exec noctalia-shell ipc call lockScreen lock";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";

          # Workspace switching
          "${modifier}+1" = "workspace 1:";
          "${modifier}+2" = "workspace 2:";
          "${modifier}+3" = "workspace 3:󰇮";
          "${modifier}+4" = "workspace 4:󰵅";
          "${modifier}+5" = "workspace 5:󰊴";
          "${modifier}+6" = "workspace 6:";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";

          # Move containers to workspace
          "${modifier}+Shift+1" = "move container to workspace 1:";
          "${modifier}+Shift+2" = "move container to workspace 2:";
          "${modifier}+Shift+3" = "move container to workspace 3:󰇮";
          "${modifier}+Shift+4" = "move container to workspace 4:󰵅";
          "${modifier}+Shift+5" = "move container to workspace 5:󰊴";
          "${modifier}+Shift+6" = "move container to workspace 6:";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";

          # Resize mode
          "${modifier}+r" = "mode resize";

          # Media keys
          "XF86AudioRaiseVolume" = "exec  wpctl set-volume @DEFAULT_SINK@ 10%+";
          "XF86AudioLowerVolume" = "exec  wpctl set-volume @DEFAULT_SINK@ 10%-";
          "XF86AudioMute" = "exec  wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec  wpctl set-mute @DEFAULT_SOURCE@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";

          # Brightness control
          "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";

          "${modifier}+g" = "move workspace to output right";
          "${modifier}+o" = "exec  flameshot gui";
          "${modifier}+p" = "exec noctalia-shell ipc call plugin:translator toggle \"ar\" \"\"";
          "${modifier}+b" = "exec  firefox";
          "${modifier}+Tab" = "exec pkill -USR1 sov";
        };

        # Resize mode definition
        modes = {
          resize = {
            "j" = "resize shrink width 10 px or 10 ppt";
            "k" = "resize grow height 10 px or 10 ppt";
            "l" = "resize shrink height 10 px or 10 ppt";
            "semicolon" = "resize grow width 10 px or 10 ppt";
            "Left" = "resize shrink width 10 px or 10 ppt";
            "Down" = "resize grow height 10 px or 10 ppt";
            "Up" = "resize shrink height 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };

        # Window assignments
        assigns = {
          "1:" = [ { class = "firefox"; } ];
          "2:" = [ { class = "Code"; } ];
          "3:󰇮" = [ { class = "thunderbird"; } ];
          "4:󰵅" = [
            { class = "Slack"; }
            { class = "discord"; }
          ];
          "5:󰊴" = [ { class = "steam"; } ];
        };

        startup = [
          { command = "noctalia-shell"; }
          { command = "sov"; }
          {
            command = "wl-paste --type text --watch cliphist store";
            always = true;
          }
          {
            command = "wl-paste --type image --watch cliphist store";
            always = true;
          }
        ];
        # Colors
        colors = {
          focused = {
            border = "#33CCFF";
            background = "#303446";
            text = "#C6D0F5";
            indicator = "#33CCFF";
            childBorder = "#33CCFF";
          };
          focusedInactive = {
            border = "#232634";
            background = "#232634";
            text = "#C6D0F5";
            indicator = "#44475A";
            childBorder = "#44475A";
          };
          unfocused = {
            border = "#282A36";
            background = "#282A36";
            text = "#BFBFBF";
            indicator = "#282A36";
            childBorder = "#282A36";
          };
          urgent = {
            border = "#44475A";
            background = "#FF5555";
            text = "#F8F8F2";
            indicator = "#FF5555";
            childBorder = "#FF5555";
          };
          placeholder = {
            border = "#282A36";
            background = "#282A36";
            text = "#F8F8F2";
            indicator = "#282A36";
            childBorder = "#282A36";
          };
        };
      };
    };
  };
}

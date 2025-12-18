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
      package = pkgs.i3;
      config = {
        modifier = "Mod4";

        bars = [];
        defaultWorkspace = "1";

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
          # Launch terminal
          "${modifier}+Return" = "exec --no-startup-id konsole";

          # Kill focused window
          "${modifier}+q" = "kill";

          # Launch app launcher
          "${modifier}+d" = "exec --no-startup-id rofi -show run";

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

          # Reload/restart i3
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

          # Resize mode
          "${modifier}+r" = "mode resize";

          # Media keys
          "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 10%+";
          "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 10%-";
          "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SOURCE@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";

          # Brightness control
          "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";

          "${modifier}+g" = "move workspace to output right";
          "${modifier}+o" = "exec --no-startup-id flameshot gui";
          "${modifier}+b" = "exec --no-startup-id firefox";
          "${modifier}+Tab" = "exec --no-startup-id wallpaper-changer";
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
            "${config.xsession.windowManager.i3.config.modifier}+r" = "mode default";
          };
        };

        # Window assignments
        assigns = {
          "1:" = [{class = "firefox";}];
          "2:" = [{class = "Code";}];
          "3:󰇮" = [{class = "thunderbird";}];
          "4:󰵅" = [{class = "Slack";} {class = "discord";}];
          "5:󰊴" = [{class = "steam";}];
        };

        # Startup applications
        startup = [
          {
            command = "picom -b";
            always = true;
            notification = false;
          }
          {
            command = "dex --autostart --environment i3";
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            notification = false;
          }
          {
            command = "autorandr --change";
            notification = false;
          }
          {
            command = "emote";
            notification = false;
          }
          {
            command = "launch_polybar";
            notification = false;
          }
          {
            command = "wallpaper-changer";
            notification = false;
          }
          # { command = "${config.home.homeDirectory}/.config/i3/run_xbindkeys.sh"; always = true; notification = false; }
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

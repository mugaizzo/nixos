{
  config,
  lib,
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    script = "polybar bottoml &";

    settings = {
      "colors" = {
        background = "#282A2E";
        background-alt = "#373B41";
        foreground = "#C5C8C6";
        primary = "#33CCFF";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
      };

      "bar/bottoml" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "37pt";
        radius = 0;
        bottom = false;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        line-size = "4pt";

        border-size = "0pt";
        border-color = "#00000000";

        padding-left = 0;
        padding-right = 1;

        module-margin = 1;

        font = [
          "MartianMono NF:10;1"
          "Noto Kufi Arabic:10;1"
        ];

        modules-left = "xworkspaces xwindow";
        modules-right = "pulseaudio memory cpu wlan eth bluetooth battery xkeyboard date tray power";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        enable-ipc = true;
      };
      "module/tray" = {
        type = "internal/tray";
        format-margin = "8pt";
        tray-spacing = "16pt";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";

        label-active = "%name%";
        label-active-background = "\${colors.background-alt}";
        label-active-underline = "\${colors.primary}";
        label-active-padding = 1;

        label-occupied = "%name%";
        label-occupied-padding = 1;

        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 1;

        label-empty = "%name%";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:25:...%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume-prefix = "󰕾 ";
        format-volume-prefix-foreground = "\${colors.primary}";
        format-volume = "<label-volume>";

        label-volume = "%percentage%%";
        click-right = "exec pavucontrol &";
        label-muted = "muted";
        label-muted-foreground = "\${colors.disabled}";
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";

        label-layout = "%layout%";
        label-layout-foreground = "\${colors.primary}";

        label-indicator-padding = 2;
        label-indicator-margin = 1;
        label-indicator-foreground = "\${colors.background}";
        label-indicator-background = "\${colors.secondary}";
      };

      "network-base" = {
        type = "internal/network";
        interval = 5;
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
      };

      "module/wlan" = {
        "inherit" = "network-base";
        interface-type = "wireless";
        label-connected = "%{F#33CCFF}%{A1:rofi-wifi &:} %{F-}%essid%%{A}";
        label-disconnected = "%{A1:rofi-wifi &:}󰖪 %{A}";
        click-left = "rofi-wifi &";
      };

      "module/eth" = {
        "inherit" = "network-base";
        interface-type = "wired";
        label-connected = "%{F#33CCFF}󰈀 %{F-}";
        label-disconnected = "%{F#707880}  ";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        full-text = "{status}";
        empty-text = "Empty";
        format-charging = "<label-charging>";
        format-discharging = "<label-discharging>";
        format-full = "%{F#00FF00}󰁹 %100";
        label-discharging = "%{F#FF0000}󰂀 %percentage%%";
        label-charging = "%{F#2E9FFF}󰂀 %percentage%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "󱑌 %I:%M%p";
        label = "%date%";
        label-foreground = "\${colors.primary}";
      };

      "module/bluetooth" = {
        type = "custom/script";
        exec = "rofi-bluetooth --status";
        interval = 1;
        click-left = "rofi-bluetooth &";
      };

      "module/power" = {
        type = "custom/text";
        format = "<label>";
        format-padding = 1;
        label = "⏻";
        click-left = "rofi-power &";
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "konsole";

    # Configure all the settings from the original file
    extraConfig = {
      modi = "run,window,combi";
      icon-theme = "Oranchelo";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-combi = " 🖥️  All ";
      display-run = " 󰜎  Run ";
      display-window = " 🪟  Window";
      sidebar-mode = true;
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;

      # Color values from rounded-blue-dark.rasi
      bg0 = mkLiteral "#212121F2";
      bg1 = mkLiteral "#2A2A2A";
      bg2 = mkLiteral "#3D3D3D80";
      bg3 = mkLiteral "#1A73E8F2";
      fg0 = mkLiteral "#E6E6E6";
      fg1 = mkLiteral "#FFFFFF";
      fg2 = mkLiteral "#969696";
      fg3 = mkLiteral "#3D3D3D";
    in {
      "*" = {
        font = mkLiteral "\"Maple Mono Normal NL NF 18\"";
        background-color = mkLiteral "transparent";
        text-color = fg0;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      "window" = {
        location = mkLiteral "north";
        y-offset = mkLiteral "calc(50% - 176px)";
        width = 1000;
        border-radius = mkLiteral "24px";
        background-color = bg0;
      };

      "mainbox" = {
        padding = mkLiteral "12px";
      };

      "inputbar" = {
        background-color = bg1;
        border-color = bg3;
        border = mkLiteral "2px";
        border-radius = mkLiteral "16px";
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = map mkLiteral ["prompt" "entry"];
      };

      "prompt" = {
        text-color = fg2;
      };

      "entry" = {
        placeholder = mkLiteral "\"Search\"";
        placeholder-color = fg3;
      };

      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "16px";
        border-color = bg2;
        background-color = bg2;
      };

      "textbox" = {
        padding = mkLiteral "8px 24px";
      };

      "listview" = {
        background-color = mkLiteral "transparent";
        margin = mkLiteral "12px 0 12px";
        lines = 8;
        columns = 1;
        fixed-height = false;
      };

      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "16px";
      };

      "element normal active" = {
        text-color = bg3;
      };

      "element alternate active" = {
        text-color = bg3;
      };

      "element selected normal, element selected active" = {
        background-color = bg3;
      };

      "element-icon" = {
        size = mkLiteral "1em";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
      };

      "#button.selected" = {
        background-color = bg3;
        border-radius = mkLiteral "24px";
        padding = mkLiteral "12px";
      };
    };
  };
}

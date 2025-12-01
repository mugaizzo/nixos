{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.ghostty.enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf config.terminal.ghostty.enable {
    home.packages = with pkgs; [
      imv
      ripgrep
      bat
      bottom
      atool
      unzip
      imagemagick
      duf
      trash-cli
      mpv
      yt-dlp
      tealdeer
      ffmpeg
      wl-clipboard
      bc
      hyperfine
    ];

    programs.ghostty = {
      enable = true;

      settings = {
        auto-update = "off";

        cursor-style = "bar";
        cursor-style-blink = false;
        adjust-cursor-thickness = "200%";

        theme = "catppuccin-mocha";

        font-family = "JetBrainsMono Nerd Font";
        font-size = 14;

        keybind = [
          "clear"
          "performable:alt+c=copy_to_clipboard"
          "performable:alt+v=paste_from_clipboard"
        ];

        window-padding-x = 15;
        window-padding-y = 15;

        shell-integration-features = "no-cursor,no-sudo,title";

        window-decoration = false;
        resize-overlay = "never";
        confirm-close-surface = false;
        gtk-single-instance = true;
        quit-after-last-window-closed = false;
      };
    };
  };
}

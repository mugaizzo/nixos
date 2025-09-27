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
        fonts = {
          names = ["Noto Kufi Arabic"];
          size = 9;
        };
        gaps = {
          inner = 10;
          outer = 5;
        };
        terminal = "konsole";
      };
    };
  };
}

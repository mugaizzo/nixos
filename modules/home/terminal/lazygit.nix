{
  lib,
  config,
  ...
}: {
  options = {
    terminal.lazygit.enable = lib.mkEnableOption "enable lazygit";
  };

  config = lib.mkIf config.terminal.lazygit.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options = {
    terminal.git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.terminal.git.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "mugaizzo";
          email = "mugahedman@hotmail.com";
        };
        extraConfig = {
          credential.helper = "store --file ~/.ssh/config";
        };
      };
    };
  };
}

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

      userName = "mugaizzo";
      userEmail = "mugahedman@hotmail.com";

      settings = {
        extraConfig = {
          credential.helper = "store --file ~/.ssh/config";
        };
      };
    };
  };
}

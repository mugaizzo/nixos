{
  pkgs,
  username,
  ...
}: let
  files = [
    # "hyprlandMoveWorkspace.nix"
    # "hyprlandSetWorkspace.nix"
    # "bookmarkMenu.nix"
    # "takeScreenshot.nix"
    # "toggleMicrophone.nix"
    # "brightness.nix"
    # "keyboardBrightness.nix"
    # "musicMenu.nix"
    # "backup.nix"
    # "update-system.nix"
    "launch_polybar.nix"
    "bluetooth_menu.nix"
    "wifi_menu.nix"
    "power_menu.nix"
    "wallpaper_changer.nix"
    "sala.nix"
  ];

  importPkg = file: import ./${file} {inherit pkgs username;};
in {
  home.packages =
    map importPkg files;
}

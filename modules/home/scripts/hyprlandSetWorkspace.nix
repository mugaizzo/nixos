{pkgs, ...}:
pkgs.writeShellScriptBin "hyprland-set-workspace" ''
  monitor=$(hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[] | select(.focused == true).id')
  workspace=$(( $1 + (10 * $monitor)))

  hyprctl dispatch workspace $workspace
''

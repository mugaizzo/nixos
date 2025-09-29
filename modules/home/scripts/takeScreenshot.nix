{pkgs, ...}:
pkgs.writeShellScriptBin "take-screenshot" ''
  if pgrep -x "slurp" > /dev/null; then
      exit
  fi

  GEOM=$(${pkgs.slurp}/bin/slurp -b "#1E1E2EA0" -c "#CBA6F7")

  ${pkgs.grim}/bin/grim -g "$GEOM" - | ${pkgs.wl-clipboard}/bin/wl-copy
''

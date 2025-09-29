{pkgs, ...}:
pkgs.writeShellScriptBin "brightness" ''
  if [[ "$#" != 1 ]] || [[ ! ("$1" == "inc" || "$1" == "dec") ]]; then
      echo "Usage: $0 [inc|dec]" >&2
      exit 1
  fi

  if [[ "$1" == "inc" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl set +5% > /dev/null
  elif [[ "$1" == "dec" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl set 5%- > /dev/null
  fi
''

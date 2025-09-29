{pkgs, ...}:
pkgs.writeShellScriptBin "keyboard-brightness" ''
  if [[ "$#" != 1 ]] || [[ ! ("$1" == "inc" || "$1" == "dec") ]]; then
      echo "Usage: $0 [inc|dec]" >&2
      exit 1
  fi

  DEVICE="system76_acpi::kbd_backlight"

  if [[ "$1" == "inc" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl --device="$DEVICE" set +5% > /dev/null
  elif [[ "$1" == "dec" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl --device="$DEVICE" set 5%- > /dev/null
  fi
''

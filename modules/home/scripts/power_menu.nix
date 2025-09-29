{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-power" ''
  # Power menu script using tofi

  CHOSEN=$(printf "Lock\nSuspend\nReboot\nPoweroff\nLog Out" | rofi -dmenu -i )

  case "$CHOSEN" in
  "Lock") i3lock ;;
  "Suspend") systemctl suspend ;;
  "Reboot") reboot ;;
  "Poweroff") poweroff ;;
  "Log Out") i3-msg exit;;
  *) exit 1 ;;
  esac
''

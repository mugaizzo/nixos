{pkgs, ...}:
pkgs.writeShellScriptBin "launch_polybar" ''

  # launch polybar
  killall polybar

  if ! pgrep -x "polybar" > /dev/null; then
  for m in $(xrandr --listactivemonitors | awk '/Monitors:/{next} {print $NF}'); do
    MONITOR=$m polybar --reload bottoml &
  done
  fi
''

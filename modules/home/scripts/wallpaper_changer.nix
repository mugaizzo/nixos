{pkgs, ...}:
pkgs.writeShellScriptBin "wallpaper-changer" ''

  horizental=$(shuf -e -n1 ~/Pictures/wallpaper/*)
  virtical=$(shuf -e -n1 ~/Pictures/virt_wallpaper/*)
  if [[ $(autorandr --current) == 'virt' ]]; then
    feh --bg-scale "$horizental" "$virtical"
  elif [[ $(autorandr --current) == 'tri' ]]; then
    feh --bg-scale "$horizental" "$horizental" "$virtical"
  else
    feh --bg-scale "$horizental"
  fi
''

{pkgs, ...}:
pkgs.writeShellScriptBin "music-menu" ''
  CACHE_FILE="$HOME/.cache/mpd_dirs_cache"
  CACHE_TTL=86400 # 24 hours

  # Regenerate cache if needed
  if [ ! -f "$CACHE_FILE" ] || [ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -gt $CACHE_TTL ]; then
      mpc listall | sed 's|/[^/]*$||' | sort -u >"$CACHE_FILE"
  fi

  # Read cached dirs
  dirs=$(cat "$CACHE_FILE")

  if [ -z "$dirs" ]; then
      notify-send "Music Menu" "No directories found" -t 5000
      exit 1
  fi

  # Add volume options to the top of the list
  menu_items=$(printf "%s\n" \
      "Increase Volume" \
      "Decrease Volume" \
      "$dirs")

  # Show selection menu
  selection=$(printf "%s\n" "$menu_items" | tofi)

  if [ -z "$selection" ]; then
      exit 0
  fi

  case "$selection" in
  "Increase Volume")
      mpc volume +5
      exit 0
      ;;
  "Decrease Volume")
      mpc volume -5
      exit 0
      ;;
  *)
      mpc clear
      mpc add "$selection"
      mpc play
      ;;
  esac
''

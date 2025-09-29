{pkgs, ...}:
pkgs.writeShellScriptBin "toggle-microphone" ''
  volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

  # Check if the output contains "[MUTED]"
  if echo "$volume_info" | grep -q '\[MUTED\]'; then
      muted=true
  else
      muted=false
  fi

  if [ "$muted" = true ]; then
      wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
      notify-send "Toggle Microphone" "The microphone has been enabled" -t 1000
  else
      wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
      notify-send "Toggle Microphone" "The microphone has been disabled" -t 1000
  fi
''

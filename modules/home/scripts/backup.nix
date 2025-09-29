{
  pkgs,
  username,
  ...
}:
pkgs.writeShellScriptBin "backup" ''
  set -eu

  destination="/run/media/${username}/Backups"
  home="home_backups"
  linkdir="latest"
  timestamp=$(date +%Y-%m-%d_%H:%M:%S)
  logfile="$timestamp.log"
  rsync_options="-avhPl"

  # Check if the destination directory exists
  if [ ! -d "$destination" ]; then
      notify-send "Backup Drive Not Found" "The backup drive was not found. Please check your backup drive."
      exit 1
  fi

  # Check if the backup drive is close to full
  if [ "$(df -h "$destination" | awk 'NR==2 {print $5}' | sed 's/%//')" -ge 95 ]; then
      notify-send "Backup Drive Full" "The backup drive is close to full. Please free up some space."
      exit 1
  fi

  # Create TL dirs
  mkdir -p "$destination"/"$home"/"$timestamp"

  # Take an incremental snapshot of $HOME
  rsync $rsync_options \
      --exclude='*deps/*' \
      --exclude='*node_modules/*' \
      --include='.zen' \
      --include='.ideavimrc' \
      --include='.config/FreeTubn/*.db' \
      --include='.config/nixos' \
      --exclude='.*' \
      "$HOME/" "$destination/$home/$timestamp/data" \
      --link-dest="$destination/$home/$linkdir" > "$destination/$home/$timestamp/$logfile"

  # Create symlink to the latest backup
  ln -sfn "$destination/$home/$timestamp/data" "$destination/$home/$linkdir"

  notify-send "Backup Complete" "The backup has been completed." -t 5000
''

{pkgs, ...}:
pkgs.writeShellScriptBin "update-system" ''
  set -e

  PROFILE="$1"
  DOTFILES="$2"

  if [ -z "$PROFILE" ]; then
    echo "Usage: $0 <profile> [<dotfiles directory>]"
    exit 1
  fi

  if [ -z "$DOTFILES" ]; then
    DOTFILES="$HOME/.config/nixos"
  fi

  cd "$DOTFILES"

  git pull

  nix flake update --flake "$DOTFILES"

  git add .

  sudo nixos-rebuild switch --flake "$DOTFILES#$PROFILE"

  NOW="$(date '+%Y-%m-%d %H:%M:%S')"
  VERSION=$(nixos-rebuild list-generations --json | ${pkgs.jq}/bin/jq '.[] | select (.current == true) | (.generation)')
  MESSAGE="Version $VERSION at $NOW"

  git commit -m "$MESSAGE"
  git pull --rebase
  git push
''

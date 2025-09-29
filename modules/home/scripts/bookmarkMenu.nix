{pkgs, ...}:
pkgs.writeShellScriptBin "bookmark-menu" ''
  bookmarks=$(cat <<'EOF'
  nerdfonts.com/cheat-sheet icons
  twitch.tv
  codeberg.org/DontBlameMe github gitlab gitea
  192.168.178.1 fritz box wlan router
  streamelements.com/dashboard stream live
  dashboard.twitch.tv stream live
  app.simplelogin.io/dashboard aliases email pseudo anon
  monkeytype.com
  configure.zsa.io
  fosstodon.org mastodon federated
  dontblameme.codeberg.page website own blog
  duolingo.com language spanish
  jimpix.co.uk/words/random-username-generator.php random username generator
  deepl.com
  neetcode.io/roadmap leetcode roadmap
  leetcode.com
  libgen.li ebook torrent
  1337x.to torrent
  annas-archive.org ebook
  127.0.0.1:8384 syncthing
  privacyguides.org
  alternativeto.net
  addy.io aliases email pseudo anon
  sync-tube.de
  mynixos.com
  crates.io
  atl.wiki
  wiki.archlinux.org
  EOF
  )

  # Exit if bookmarks are empty (shouldn't be the case here)
  [ -z "$bookmarks" ] && exit

  # Use awk and tofi on the inline here-doc content instead of a file
  selection=$(printf "%s\n" "$bookmarks" | awk '{printf "%-*s%s\n", 50, $1, substr($0, index($0, $2))}' | tofi)

  # Exit if no selection
  [ -z "$selection" ] && exit

  # Extract URL and description like before
  url=$(printf "%s" "$selection" | awk '{print $1}')
  description=$(printf "%s" "$selection" | awk '{$1=""; print $0}')

  # Open URL in browser
  xdg-open "https://$url"
''

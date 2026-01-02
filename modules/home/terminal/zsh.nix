{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.zsh.enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.terminal.zsh.enable {
    home.packages = with pkgs; [
      # imv
      ripgrep
      bat
      # bottom
      # atool
      unzip
      imagemagick
      # mpv
      # yt-dlp
      tealdeer
      bc
      fzf 
      zoxide 
      direnv
      python313Packages.argcomplete
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        size = 5000;
        save = 5000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
        append = true;
      };
      shellAliases = {
        ls = "ls --color --hyperlink=auto";
        ll = "ls -laF";
        la = "ls -A";
        l = "ls -CF";
        # edge = "microsoft-edge";
        # pika = "flatpak run org.gnome.World.PikaBackup";
        files = "nautilus";
        vim = "nvim";
        v = "nvim";
        hs = "upower -i $(upower -e | grep headset)";
        wttr = "curl wttr.in/40.76802547849189,-111.85571559297684";
        y = "yazi";
        ip = "ip -color=auto";
      };
      initContent = ''
        # Powerlevel10k prompt
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # Keybindings
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^[w' kill-region
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word
        bindkey "^[[3~" delete-char

        # FZF integration
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        eval "$(fzf --zsh)"

        # zoxide
        eval "$(zoxide init --cmd cd zsh)"

        # pipx argcomplete
        eval "$(register-python-argcomplete pipx)"

        # direnv
        eval "$(direnv hook zsh)"

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "\$\{s.:. LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      '';
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
        }
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
        }
        # zsh-autosuggestions and zsh-syntax-highlighting are enabled above
      ];
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo" "aws" "kubectl" "kubectx" "command-not-found"];
      };
    };
  };
}

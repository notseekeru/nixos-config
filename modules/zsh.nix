{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      package = pkgs.oh-my-zsh;
      theme = "agnoster";
      plugins = [ "git" "sudo" "history" "npm" ];
    };

    initContent = ''
      if type direnv &>/dev/null; then
        eval "$(direnv hook zsh)"
      fi

      if [ -f ~/gh-token ]; then
        export GH_TOKEN=$(cat ~/gh-token)
      fi

      export KUBECONFIG=~/kubeconfig

      # Auto-init reproducible tmux sessions and attach
      if [[ -z "$TMUX" && -z "$TMUX_INIT" ]]; then
        export TMUX_INIT=1
        if command -v tmux &>/dev/null; then
          # Create sessions if they don't exist yet
          [ -x ~/.local/bin/tmux-init-sessions ] && ~/.local/bin/tmux-init-sessions
          # Attach to session 0 at the home window
          tmux new-session -A -D -s 0 \; select-window -t home 2>/dev/null || \
            tmux new-session -A -s main
        fi
      fi
    '';

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      lg = "lazygit";
      da = "direnv allow";
      dr = "direnv reload";
      mountboot = "sudo mount /dev/sda1 /boot";
      garbage = "nix-collect-garbage -d";
      rb = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .\#\$(hostname) --show-trace";
      clrb = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .\#\$(hostname) --refresh --show-trace";
      update = "cd ~/nixos-config && sudo nix flake update --extra-experimental-features 'nix-command flakes'";

      t0 = "tmux a -t 0";
      t1 = "tmux a -t 1";
      t2 = "tmux a -t 2";
      t3 = "tmux a -t 3";

      k = "kubectl";

      gcm = ''git add -A && git diff --cached --stat && read -q "REPLY?Commit? (y/N): " && echo && [[ "$REPLY" != [yY] ]] && echo Aborted. || git commit -m "$(echo Generate a short conventional commit message with scope, properly and cleanly for: $(git diff --cached --stat | tr '\n' ' ') | pi --provider deepseek --model deepseek-v4-flash 2>/dev/null)"'';
    };
  };
}

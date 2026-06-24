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
    };
  };
}

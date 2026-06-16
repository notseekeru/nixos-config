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

    initExtra = ''
      if type direnv &>/dev/null; then
        eval "$(direnv hook zsh)"
      fi

      if [ -f ~/gh-token ]; then
        export GH_TOKEN=$(cat ~/gh-token)
      fi 
    '';

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      lg = "lazygit";
      da = "direnv allow";
      dr = "direnv reload";
      mountboot = "sudo mount /dev/sda1 /boot";
      config = "nvim ~/nixos-config/configuration.nix";
      garbage = "nix-collect-garbage -d";
      rebuild = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .\#\$(hostname) --show-trace";
      cleanrebuild = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .\#\$(hostname) --refresh --show-trace";
      update = "cd ~/nixos-config && sudo nix flake update --extra-experimental-features 'nix-command flakes'";
    };
  };
}

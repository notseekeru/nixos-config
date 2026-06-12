{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      package = pkgs.oh-my-zsh;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "history" "npm" ];
    };

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      mountboot = "sudo mount /dev/sda1 /boot";
      rebuild = "sudo nixos-rebuild switch --flake .#nixos --show-trace";
    };
  };
}

{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "history" "npm" ];
    };

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      mountboot = "sudo mount /dev/sda1 /boot";
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
    };
  };
}

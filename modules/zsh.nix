{ pkgs, ... }: {

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
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

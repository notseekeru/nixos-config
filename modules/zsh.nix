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

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      mountboot = "sudo mount /dev/sda1 /boot";
      config = "nvim ~/nixos-config/configuration.nix";
      garbage = "nix-collect-garbage -d";
      rebuild = "sudo nixos-rebuild switch --flake .#nixos --show-trace";
      cleanrebuild = "sudo nixos-rebuild switch --flake .#nixos --refresh --show-trace";
    };
  };
}

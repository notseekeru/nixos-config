   { config, pkgs, ... }:

{
  imports = [
  ./modules/zsh.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    kitty
    pi-coding-agent
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.tmux.enable = true;
  programs.git.enable = true;

  programs.home-manager.enable = true; # Always leave this enabled
}

{ config, pkgs, ... }:

{
  imports = [
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/hyprland-home.nix
    ./modules/tmux.nix
    ./modules/neovim/default.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    vim
    gh
    brave
    obsidian
    pi-coding-agent
    pre-commit
    gitleaks
  ];

  programs.home-manager.enable = true; # Always leave this enabled
}

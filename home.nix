{ config, pkgs, ... }:

{
  imports = [
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/hyprland-home.nix
    ./modules/tmux.nix
    ./modules/kitty
    ./modules/neovim/init.nix
    ./modules/greeter.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  services.fstrim.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    vim
    gh
    obsidian
    brave
    pi-coding-agent
    pre-commit
    gitleaks
  ];

  programs.home-manager.enable = true;
}


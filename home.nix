{ config, pkgs, ... }:

{
  imports = [
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/neovim/init.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  fonts.fontconfig.enable = true;

  # Cross-platform packages (available on all machines)
  home.packages = with pkgs; [
    vim
    gh
    pi-coding-agent
    pre-commit
    gitleaks
  ];

  programs.home-manager.enable = true;
}

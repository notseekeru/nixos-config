   { config, pkgs, ... }:

{
  imports = [
  ./modules/zsh.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
    kitty
    neovim
    tmux
    nodejs
  ];

  programs.neovim.enable = true;
  programs.tmux.enable = true;
  programs.git.enable = true;

  programs.home-manager.enable = true; # Always leave this enabled
}

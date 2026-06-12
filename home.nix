   { config, pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/hyprland-home.nix
    ./modules/tmux.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  fonts.fontconfig.enable=true;

  home.packages = with pkgs; [
    nerd-fonts.geist-mono
    vim
    pi-coding-agent
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.git.enable = true;

  programs.home-manager.enable = true; # Always leave this enabled
}

   { config, pkgs, ... }:

   {
     home.username = "seeker";
     home.homeDirectory = "/home/seeker";
     home.stateVersion = "26.05";

     # Manage your dotfiles here
     programs.neovim.enable = true;
     programs.tmux.enable = true;
     programs.git.enable = true;

     programs.home-manager.enable = true; # Always leave this enabled
   }

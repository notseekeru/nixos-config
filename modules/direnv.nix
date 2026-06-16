{ pkgs, ... }:

{
  # direnv with nix-direnv for automatic shell environments
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    enableZshIntegration = true;
  };
}

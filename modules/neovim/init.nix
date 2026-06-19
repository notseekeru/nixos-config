{ config, pkgs, ... }:

{
  imports = [
    ./binaries.nix
    ./plugins.nix
    ./lsp.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Load the main init.lua from the external file
    initLua = builtins.readFile ./init.lua;
  };
}

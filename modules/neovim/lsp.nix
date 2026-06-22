{ lib, ... }:

with lib;

{
  # This module ensures the lsp.lua file is placed into Neovim's config directory.
  # The file is linked via xdg.configFile so Neovim can load it with dofile().
  xdg.configFile."nvim/lsp.lua".source = ./lsp.lua;
}

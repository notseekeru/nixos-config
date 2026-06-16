{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-lspconfig
      blink-cmp
      snacks-nvim
      harpoon2
      flash-nvim
      conform-nvim
    ];
  };
}

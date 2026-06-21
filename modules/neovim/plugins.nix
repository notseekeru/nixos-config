{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    nvim-treesitter-parsers.go          # Go tree-sitter parser
    nvim-treesitter-parsers.rust        # Rust tree-sitter parser
    nvim-treesitter-parsers.python      # Python tree-sitter parser
    nvim-treesitter-parsers.lua         # Lua tree-sitter parser
    nvim-treesitter-parsers.nix         # Nix tree-sitter parser
    nvim-treesitter-parsers.bash        # Bash tree-sitter parser
    nvim-treesitter-parsers.json        # JSON tree-sitter parser
    nvim-treesitter-parsers.yaml        # YAML tree-sitter parser
    nvim-treesitter-parsers.markdown    # Markdown tree-sitter parser
    nvim-treesitter-parsers.css         # CSS tree-sitter parser
    nvim-treesitter-parsers.html        # HTML tree-sitter parser
    nvim-treesitter-parsers.javascript  # JavaScript tree-sitter parser
    nvim-treesitter-parsers.typescript  # TypeScript tree-sitter parser
    nvim-treesitter-parsers.dockerfile  # Dockerfile tree-sitter parser
    nvim-lspconfig
      blink-cmp
      snacks-nvim
      harpoon2
      flash-nvim
      conform-nvim
      codediff-nvim
      catppuccin-nvim                   # Colorscheme
    ];
  };
}

{ pkgs, ... }:

let
  tsParser = pkgs.vimPlugins.nvim-treesitter-parsers;
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (_p: [
        tsParser.go          # Go
        tsParser.rust        # Rust
        tsParser.python      # Python
        tsParser.lua         # Lua
        tsParser.nix         # Nix
        tsParser.bash        # Bash
        tsParser.json        # JSON
        tsParser.yaml        # YAML
        tsParser.markdown    # Markdown
        tsParser.css         # CSS
        tsParser.html        # HTML
        tsParser.javascript  # JavaScript
        tsParser.typescript  # TypeScript
        tsParser.dockerfile  # Dockerfile
      ]))
      nvim-web-devicons                  # File/icon provider for picker, explorer, etc.
      nvim-lspconfig
      blink-cmp
      snacks-nvim
      harpoon2
      flash-nvim
      conform-nvim
      codediff-nvim
      bufferline-nvim                   # Chrome-style tabs at the top
      catppuccin-nvim                   # Colorscheme
      persistence-nvim                  # Auto-save/restore session (LazyVim-style)
    ];
  };
}

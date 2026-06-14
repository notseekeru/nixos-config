{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # === Must-Have Stack ===
      nvim-treesitter                # Syntax highlighting & parsing
      nvim-lspconfig                 # LSP client configuration
      blink-cmp                      # Completion engine
      snacks-nvim                    # Utility suite (replaces mini, noice, etc.)
      harpoon2                       # Active context management
      mini-files                     # File system management
      flash-nvim                     # Intra-file motion
      conform-nvim                   # Formatting (uses LSP + standalone formatters)
      # === Treesitter parsers (pre-compiled) ===
      # Additional parsers beyond the built-in ones are bundled by nvim-treesitter

      # === blink-cmp sources ===
      # blink-cmp comes with LSP, buffer, path sources built-in
      # No extra source plugins needed for basic setup
    ];
  };
}

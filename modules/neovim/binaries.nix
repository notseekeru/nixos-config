{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # === LSP Servers ===
    nil                                   # Nix language server
    lua-language-server                   # Lua language server
    pyright                               # Python language server
    vtsls                                 # TypeScript/JavaScript (Volt)
    gopls                                 # Go language server
    rust-analyzer                         # Rust language server
    bash-language-server                  # Bash language server
    vscode-json-languageserver             # JSON language server
    yaml-language-server                  # YAML language server
    marksman                              # Markdown language server

    # === CLI Tools used by Neovim ===
    ripgrep                               # For grep in telescope/snacks
    fd                                    # Faster find
    fzf                                   # Fuzzy finder
    lazygit                               # Git TUI (Snacks integration)

    # === Formatting ===
    nixpkgs-fmt                           # Nix formatter

    # === Tree-sitter CLI (optional) ===
    tree-sitter
  ];
}

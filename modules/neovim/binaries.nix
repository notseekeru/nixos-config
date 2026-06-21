{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # === LSP Servers ===
    nil # Nix language server
    lua-language-server # Lua language server
    pyright # Python language server
    vtsls # TypeScript/JavaScript (Volt)
    go # Go compiler/toolchain
    gopls # Go language server
    rust-analyzer # Rust language server
    bash-language-server # Bash language server
    vscode-json-languageserver # JSON language server
    yaml-language-server # YAML language server
    marksman # Markdown language server
    dockerfile-language-server # Dockerfile language server
    terraform-ls # Terraform language server
    clang-tools # C/C++ language server (clangd)

    # === CLI Tools used by Neovim ===
    ripgrep # For grep in telescope/snacks
    fd # Faster find
    fzf # Fuzzy finder
    lazygit # Git TUI (Snacks integration)

    # === Linters ===
    selene # Lua linter
    shellcheck # Shell script linter
    hadolint # Dockerfile linter
    statix # Nix anti-pattern linter
    vale # Markdown/prose linter

    # === Formatting ===
    nixpkgs-fmt # Nix formatter
    stylua # Lua formatter
    ruff # Python formatter (also linter)
    prettierd # TS/JS/JSON/YAML/MD formatter (daemon)
    shfmt # Bash formatter
    yamlfmt # YAML formatter

    # === Tree-sitter CLI (optional) ===
    tree-sitter
  ];
}

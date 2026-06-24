{ pkgs, ... }:

{
  imports = [
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/neovim/init.nix
  ];

  home.username = "seeker";
  home.homeDirectory = "/home/seeker";
  home.stateVersion = "26.05";

  fonts.fontconfig.enable = true;

  # Cross-platform packages (available on all machines)
  home.packages = with pkgs; [
    tldr
    gcc
    gnumake
    binutils
    glibc
    vim
    gh
    pi-coding-agent
    pre-commit
    gitleaks
  ];

  programs.home-manager.enable = true;

  # Register GH token with gh CLI so git credential helper works
  # from any context (desktop apps like Obsidian, not just terminal)
  # Token is stored in ~/.config/gh/hosts.yml (perm 600) — NOT in the Nix store.
  home.activation.registerGhToken = ''
    if [ -f "$HOME/gh-token" ]; then
      token="$(cat "$HOME/gh-token")"
      if ! "${pkgs.gh}/bin/gh" auth status &>/dev/null; then
        echo "$token" | env -u GH_TOKEN "${pkgs.gh}/bin/gh" auth login --with-token
      fi
    fi
  '';
}

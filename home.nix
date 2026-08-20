{ pkgs, pi, ... }:

{
  imports = [
    pi.homeModules.default
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/tmux-init.nix
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
    pre-commit
    gitleaks
    logisim-evolution
  ];

  # Declarative pi coding-agent (install + settings + args via module)
  programs.pi.coding-agent = {
    enable = true;
    # Provider/model baked into the wrapper so the gcm alias calls plain `pi`.
    extraArgs = [
      "--provider"
      "deepseek"
      "--model"
      "deepseek-v4-flash"
    ];
  };

  programs.home-manager.enable = true;

  # Register GH token with gh CLI so git credential helper works
  # Token is stored in ~/.config/gh/hosts.yml (perm 600)
  home.activation.registerGhToken = ''
    if [ -f "$HOME/gh-token" ]; then
      token="$(cat "$HOME/gh-token")"
      if ! "${pkgs.gh}/bin/gh" auth status &>/dev/null; then
        echo "$token" | env -u GH_TOKEN "${pkgs.gh}/bin/gh" auth login --with-token
      fi
    fi
  '';
}

{ pkgs, ... }:

{
  # Creates all tmux sessions on first start
  # No dependence on resurrect save files or tmuxp
  home.file.".local/bin/tmux-init-sessions" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Creates reproducible tmux sessions — works on any machine
      set -euo pipefail

      create_session() {
        local name="$1"
        local first_dir="$2"
        local first_win="$3"
        shift 3

        if tmux has-session -t "$name" 2>/dev/null; then
          return 0
        fi

        tmux new-session -d -s "$name" -c "$first_dir" -n "$first_win"

        while [ $# -ge 2 ]; do
          tmux new-window -t "$name:" -c "$2" -n "$1"
          shift 2
        done
      }

      # Session 0: nixos-config
      create_session 0 /home/seeker/nixos-config rebuild \
        neovim /home/seeker/nixos-config \
        pi /home/seeker/nixos-config \
        home /home/seeker

      # Session 1: terraform
      create_session 1 /home/seeker/terraform terraform \
        terraform-commands /home/seeker/terraform \
        terraform-pi /home/seeker/terraform

      # Session 2: gitops
      create_session 2 /home/seeker/gitops gitops \
        gitops-command /home/seeker/gitops \
        gitops-pi /home/seeker/gitops

      # Session 3: http-engine-go
      create_session 3 /home/seeker/http-engine-go http-engine-go \
        http-commands /home/seeker/http-engine-go \
        go-http-pi /home/seeker/http-engine-go

      # Session 4: websites
      create_session 4 /home/seeker/portfolio_website zsh \
        zsh /home/seeker/portfolio_website \
        zsh /home/seeker/diagram_website \
        pi /home/seeker/diagram_website
    '';
  };
}

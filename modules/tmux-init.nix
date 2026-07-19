{ pkgs, ... }:

{
  home.file.".local/bin/tmux-init-sessions" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      create_session() {
        local name="$1"
        local first_dir="$2"
        local first_win="$3"
        shift 3

        if tmux has-session -t "$name" 2>/dev/null; then
          local win_count win_name
          win_count=$(tmux list-windows -t "$name" -F '#{window_name}' 2>/dev/null | wc -l)
          win_name=$(tmux list-windows -t "$name" -F '#{window_name}' 2>/dev/null | head -1)
          if [ "$win_count" -eq 1 ] && [ "$win_name" = "zsh" ]; then
            tmux kill-session -t "$name" 2>/dev/null || true
          else
            return 0
          fi
        fi

        tmux new-session -d -s "$name" -c "$first_dir" -n "$first_win"
        while [ $# -ge 2 ]; do
          tmux new-window -t "$name:" -c "$2" -n "$1"
          shift 2
        done
      }

      create_session nixos-config /home/seeker/nixos-config nixos-config \
        commands /home/seeker/nixos-config \
        pi /home/seeker/nixos-config \
        home /home/seeker \
 
      create_session terraform /home/seeker/terraform terraform \
        commands /home/seeker/terraform \
        pi /home/seeker/terraform

      create_session ansible /home/seeker/ansible ansible \
        commands /home/seeker/ansible \
        pi /home/seeker/ansible

      create_session gitops /home/seeker/gitops gitops \
        commands /home/seeker/gitops \
        pi /home/seeker/gitops

      create_session http-engine-go /home/seeker/http-engine-go http-engine-go \
        commands /home/seeker/http-engine-go \
        pi /home/seeker/http-engine-go

      create_session portfolio_website /home/seeker/portfolio_website portfolio \
        commands /home/seeker/portfolio_website \
        pi /home/seeker/portfolio_website

      create_session diagram_website /home/seeker/diagram_website diagram \
        commands /home/seeker/diagram_website \
        pi /home/seeker/diagram_website

      create_session auth_lib /home/seeker/auth_lib auth_lib \
        commands /home/seeker/auth_lib \
        pi /home/seeker/auth_lib 

      create_session scratch_encryption_rust /home/seeker/scratch-encryption-rust/ encyrption \
        commands /home/seeker/scratch-encryption-rust/ \
        pi /home/seeker/scratch-encryption-rust/

    '';
  };
}

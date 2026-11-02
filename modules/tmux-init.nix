{ pkgs, ... }:

{
  home.file.".local/bin/tmux-init-sessions" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      declared=" "

      create_session() {
        local name="$1"
        local first_dir="$2"
        local first_win="$3"
        shift 3
        declared="$declared$name "

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

      create_session agents /home/seeker/agents agents \
        commands /home/seeker/agents \
        pi /home/seeker/agents

      create_session seremotion /home/seeker/seremotion seremotion \
        commands /home/seeker/seremotion \
        pi /home/seeker/seremotion

      create_session sesume /home/seeker/sesume sesume \
        commands /home/seeker/sesume \
        pi /home/seeker/sesume

      create_session maxterview_website /home/seeker/maxterview_website maxterview \
        commands /home/seeker/maxterview_website \
        pi /home/seeker/maxterview_website

      create_session k6-load-testing /home/seeker/k6-load-testing k6 \
        commands /home/seeker/k6-load-testing \
        pi /home/seeker/k6-load-testing

      create_session dsa-finals-psu /home/seeker/dsa-finals-psu dsa-finals-psu \
        commands /home/seeker/dsa-finals-psu \
        pi /home/seeker/dsa-finals-psu

      current=""
      if [ -n "''${TMUX:-}" ]; then
        current=$(tmux display-message -p '#S' 2>/dev/null || true)
      fi
      while read -r s; do
        case " $declared " in
          *" $s "*) continue ;;
        esac
        if [ "$s" = "$current" ]; then
          continue
        fi
        tmux kill-session -t "$s" 2>/dev/null || true
      done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null || true)

    '';
  };
}

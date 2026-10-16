{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g mouse on

      # disable drag-to-copy; yank is vi-only
      unbind-key -T copy-mode-vi MouseDragEnd1Pane
      set -s copy-command 'wl-copy'
      set -s set-clipboard on

      # ─── vi-mode copy/paste ───
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi V send -X select-line
      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi Enter send -X copy-selection-and-cancel
      bind-key ] paste-buffer
      bind-key b list-buffers
      setw -g mode-keys vi

      set -g extended-keys-format csi-u
      set -g extended-keys on
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on
      unbind-key C-o
      bind-key m select-pane -t :.+

      # Reproducible layout handled by tmux-init-sessions
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];
  };
}


{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    mouse = true;

    extraConfig = ''
      set -g extended-keys on

      set -g mouse on
      set -s copy-command 'wl-copy'
      set -s set-clipboard on

      # Start window numbering at 1 instead of 0
      set -g base-index 1
      setw -g pane-base-index 1

      # Only show windows 1-9
      set -g renumber-windows on

      # Custom key bindings
      unbind-key C-o
      bind-key m select-pane -t :.+

      # TPM plugins (loaded at runtime)
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @continuum-restore 'on'

      # Initialize TPM
      run '~/.tmux/plugins/tpm/tpm'
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
    ];
  };
}

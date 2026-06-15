{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    mouse = true;

    extraConfig = ''
      set -g mouse on
      set -s copy-command 'wl-copy'
      set -s set-clipboard on

      set -g extended-keys-format csi-u
      set -g extended-keys on

      set -g base-index 1
      setw -g pane-base-index 1

      set -g renumber-windows on

      unbind-key C-o
      bind-key m select-pane -t :.+

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @continuum-restore 'on'

      run '~/.tmux/plugins/tpm/tpm'
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
    ];
  };
}

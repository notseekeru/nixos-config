{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    mouse = true;

    extraConfig = ''
      set -g extended-keys on

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

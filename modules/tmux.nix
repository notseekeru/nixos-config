{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # mouse on
    mouse = true;

    # unbind C-o and bind m to select-pane -t :.+
    keyBindings = [
      {
        key = "C-o";
        command = "unbind-key C-o";
      }
      {
        key = "m";
        command = "select-pane -t :.+";
      }
    ];

    # Plugins using tpm (tmux plugin manager)
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tpm;
        extraConfig = ''
          # TPM plugins
          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'tmux-plugins/tmux-resurrect'
          set -g @plugin 'tmux-plugins/tmux-continuum'

          set -g @continuum-restore 'on'

          # Run TPM
          run '~/.tmux/plugins/tpm/tpm'
        '';
      }
      {
        plugin = tmux-sensible;
      }
      {
        plugin = tmux-resurrect;
      }
      {
        plugin = tmux-continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];
  };
}

{ config, pkgs, ... }: {

  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";

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
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}


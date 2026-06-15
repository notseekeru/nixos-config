{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
      # Basic keybinds
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, thunar"
        "$mod, V, togglefloating,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod, TAB, workspace, previous "

        # Audio controls with wpctl
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ];

      binds = {
        workspace_back_and_forth = true;
      };
    };
  };

  home.packages = with pkgs; [
    waybar
    wofi
    dunst
    kitty
    networkmanagerapplet
  ];
}

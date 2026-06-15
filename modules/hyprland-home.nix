{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
      "$mod" = "SUPER";

      monitor = [
        ",preferred,auto,1.2"
      ];

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, thunar"
        "$mod, V, togglefloating,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod, TAB, workspace, previous "

        "$mod, SPACE, exec, rofi -show drun"

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
    wl-clipboard
    waybar
    rofi
    dunst
    kitty
    networkmanagerapplet
  ];
}

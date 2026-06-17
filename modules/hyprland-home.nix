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

      "exec-once" = [
        "waybar"
        "brave"
        "kitty"
        "obsidian"
        "awww-daemon"
        "awww img ~/wallpaper/default2.png"
      ];

      workspace = [
        "1, class:^(brave-browser)$, silent"
        "2, class:^(kitty)$, silent"
        "3, class:^(obsidian)$, silent"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
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

  imports = [
    ./waybar
  ];

  home.packages = with pkgs; [
    wl-clipboard
    rofi
    dunst
    pavucontrol
    btop
    networkmanagerapplet
    awww # renamed from swww to awww in nixpkgs (June 2026)
    bibata-cursors
  ];
}

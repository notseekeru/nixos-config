{ pkgs, ... }:

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
        "awww-daemon"
        "awww img ~/nixos-config/images/default2.png"
      ];

      workspace = [
        "1, class:^(brave-browser)$, silent"
        "2, class:^(kitty)$, silent"
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
        "$mod, F, fullscreen,"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"

        "$mod, SPACE, exec, rofi -show drun"

        "$mod CTRL, print, exec, grimblast copy area"
        "$mod, print, exec, grimblast copy screen"
        "$mod SHIFT, print, exec, grimblast save screen"


        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

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
    awww
    bibata-cursors
    grimblast
  ];
}

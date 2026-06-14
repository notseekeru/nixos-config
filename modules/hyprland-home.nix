{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
      # Basic keybinds
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, thunar"
        "$mod, V, togglefloating,"
      ];
      "$mod" = "SUPER";
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

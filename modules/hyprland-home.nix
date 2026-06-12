{ config, pkgs, ... }:

{
   home.packages = with pkgs; [
    waybar
    wofi
    dunst
    kitty
    networkmanagerapplet
  ];
}

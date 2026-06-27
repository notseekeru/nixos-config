{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    # Fixes 32-bit audio and performance issues on Nvidia/Hyprland
    extraPackages = with pkgs; [
      mangohud
      gamemode
    ];
  };
}

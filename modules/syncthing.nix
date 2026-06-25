{ config, pkgs, lib, ... }:

let
  inherit (lib) mkIf mkDefault;
  user = "seeker";
  homeDir = "/home/${user}";
  resurrectDir = "${homeDir}/.tmux/resurrect";
in
{
  # ─── Syncthing ───
  services.syncthing = {
    enable = true;
    user = user;
    dataDir = "${homeDir}/.syncthing";
    configDir = "${homeDir}/.config/syncthing";

    # Syncthing will discover peers via LAN and Tailscale.
    # Settings are synced between devices via the Syncthing protocol itself,
    # so the actual folder IDs and device IDs are configured once via the GUI.

    guiAddress = "127.0.0.1:8384";
    overrideFolders = false;  # Let the GUI manage folder config
    overrideDevices = false;  # Let the GUI manage device config
  };

  # Open firewall for Syncthing LAN discovery (UDP) and TCP sync
  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  # Ensure the tmux-resurrect directory exists
  systemd.tmpfiles.rules = [
    "d ${resurrectDir} 0755 ${user} ${user} -"
  ];
}

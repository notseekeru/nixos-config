{ pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/syncthing.nix
  ];

  networking.hostName = "server";

  # SSH for remote access
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Server development packages
  environment.systemPackages = with pkgs; [
    git
  ];
}

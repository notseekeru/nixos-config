{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "server";

  # SSH for remote access
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Docker for development
  virtualisation.docker.enable = true;

  # Server development packages
  environment.systemPackages = with pkgs; [
    docker-compose
    git
  ];
}

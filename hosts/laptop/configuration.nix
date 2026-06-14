{ config, lib, pkgs, ... }:

{
  services.displayManager.ssdm.enable = true;

  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  services.fstrim.enable = true;
}

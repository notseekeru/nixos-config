{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;

  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  services.fstrim.enable = true;
}

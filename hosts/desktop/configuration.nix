{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm.enable = false; # False for now due to issues

  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  services.fstrim.enable = true;
}

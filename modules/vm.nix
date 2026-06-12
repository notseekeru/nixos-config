{ config, lib, pkgs, ... }:

{
  # VMware guest support (only relevant on NixOS system level)
  virtualisation.vmware.guest.enable = true;

  # Crucial VMware Fixes for Hyprland
  environment.sessionVariables = {
    WLR_RENDERER = "pixman";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    AQ_DRIVERS = "pixman";
  };
}

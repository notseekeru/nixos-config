{ config, lib, pkgs, ... }:

{
 services.displayManager.sddm.enable = false; # False for now due to issues

  # NixOS-level Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Graphics hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Polkit for privilege escalation
  security.polkit.enable = true;

  # Input handling via libinput
  services.libinput.enable = true;

  # Ozone/Wayland session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}

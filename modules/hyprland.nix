{ config, lib, pkgs, ... }:

{
  # NixOS-level Hyprland configuration
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
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
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}

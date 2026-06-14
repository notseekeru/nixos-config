{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  services.fstrim.enable = true;

  # SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;  # Use X11 SDDM (more stable)
    settings = {
      General = {
        Numlock = "on";
      };
      Theme = {
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        Current = "maldives";
      };
    };
  };
  services.displayManager.defaultSession = "hyprland";

  # Intel GPU driver (required for graphical session)
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver   # VAAPI hardware acceleration
    intel-vaapi-driver   # Older Intel VAAPI
    intel-compute-runtime # For OpenCL on Intel
  ];
}

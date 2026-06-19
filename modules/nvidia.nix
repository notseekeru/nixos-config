{ config, lib, pkgs, ... }:

{
  # Nvidia GPU (GTX 1660 Super)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;       # Required for Wayland
    powerManagement.enable = false;  # Desktop - not needed
    open = false;                    # Use proprietary driver (stable on Turing)
    nvidiaSettings = true;           # Expose nvidia-settings
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}

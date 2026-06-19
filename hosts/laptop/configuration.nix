{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # VAAPI hardware acceleration
    intel-vaapi-driver # Older Intel VAAPI
    intel-compute-runtime # For OpenCL on Intel
  ];
}

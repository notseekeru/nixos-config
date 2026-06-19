{ config, lib, pkgs, ... }:

{
  # Pipewire audio (desktop/laptop only - not for server)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}

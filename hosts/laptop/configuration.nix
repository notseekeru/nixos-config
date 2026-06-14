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
    enable = false;
    wayland.enable = false;
    theme = "elarun";
    settings = {
      General = {
        Numlock = "on";
      };
      Theme = {
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        Current = "elarun"; # Reflect the theme change here as well
      };
    };
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Required for tuigreet
  users.users.greeter = {
    isNormalUser = false;
    home = "/var/lib/greetd";
    createHome = true;
  };
  services.displayManager.defaultSession = "hyprland";

  # Intel GPU driver (required for graphical session)
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # VAAPI hardware acceleration
    intel-vaapi-driver # Older Intel VAAPI
    intel-compute-runtime # For OpenCL on Intel
  ];
}

{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  services.fstrim.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  users.users.greeter = {
    isNormalUser = false;
    home = "/var/lib/greetd";
    createHome = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "uwsm start hyprland.desktop";
        user = "seeker";
      };

      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland.desktop'";
        user = "greeter";
      };
    };
  };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # VAAPI hardware acceleration
    intel-vaapi-driver # Older Intel VAAPI
    intel-compute-runtime # For OpenCL on Intel
  ];
}

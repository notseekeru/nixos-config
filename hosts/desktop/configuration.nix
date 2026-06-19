{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm.enable = false; # False for now due to issues

  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

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

}

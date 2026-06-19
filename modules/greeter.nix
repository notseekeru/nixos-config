{ config, pkgs, ... }:

{
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



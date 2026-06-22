{ ... }:

{
  # NixOS-level Hyprland configuration
  services.xserver.enable = true;

  # Graphics hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Polkit for privilege escalation
  security.polkit.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Input handling via libinput
  services.libinput.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}

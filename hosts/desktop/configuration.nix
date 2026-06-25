{ lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/greeter.nix
    ../../modules/pipewire.nix
    ../../modules/syncthing.nix
    ../../modules/nvidia.nix
  ];

  networking.hostName = "desktop";

  # ─── Tailscale (client mode) ───
  services.tailscale.enable = true;
  networking.interfaces.tailscale0.mtu = 1280;

  # SSH disabled on desktop
  services.openssh.enable = false;

  # Desktop GUI home-manager modules
  home-manager.users.seeker.imports = [
    ../../modules/hyprland-home.nix
    ../../modules/waybar
    ../../modules/kitty
  ];

  # ─── Dual monitor layout (desktop only) ───
  # DP-1 (165Hz gaming) is physically left, HDMI-A-1 (60Hz) is right
  # Override the shared single-monitor default from hyprland-home.nix
  home-manager.users.seeker.wayland.windowManager.hyprland.settings = {
    # Your existing monitor override
    monitor = lib.mkForce [
      "DP-1,1920x1080@165,0x0,1.0"
      "HDMI-A-1,1920x1080@60,1920x0,1.0"
    ];

    # Explicitly bind workspaces to physical monitors
    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:DP-1"
      "3, monitor:HDMI-A-1, default:true"
      "4, monitor:HDMI-A-1"
    ];
  };


  # Desktop-specific user packages (appended to base list from home.nix)
  home-manager.users.seeker.home.packages = lib.mkAfter (with pkgs; [
    nerd-fonts.geist-mono
    brave
  ]);
}

{ lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/greeter.nix
    ../../modules/pipewire.nix
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

  # Desktop-specific user packages (appended to base list from home.nix)
  home-manager.users.seeker.home.packages = lib.mkAfter (with pkgs; [
    nerd-fonts.geist-mono
    brave
  ]);
}

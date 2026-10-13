{ lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/greeter.nix
    ../../modules/pipewire.nix
    ../../modules/intel-gpu.nix
    ../../modules/syncthing.nix
    ../../modules/networking.nix
    ../../modules/obs.nix
  ];

  modules.obs.enable = true;
  modules.obs.hardwareEncoder = "qsv_hevc";

  networking.hostName = "laptop";

  # ─── Tailscale (client mode) ───
  services.tailscale.enable = true;
  networking.interfaces.tailscale0.mtu = 1280;

  # ─── Bluetooth ───
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # ─── SSH (tailscale0 only; openFirewall would expose 22 on every interface) ───
  services.openssh.enable = true;
  services.openssh.openFirewall = false;

  # Laptop GUI home-manager modules
  home-manager.users.seeker.imports = [
    ../../modules/hyprland-home.nix
    ../../modules/waybar
    ../../modules/kitty
  ];

  # Laptop-specific user packages (appended to base list from home.nix)
  home-manager.users.seeker.home.packages = lib.mkAfter (with pkgs; [
    nerd-fonts.geist-mono
    brave
    obsidian
  ]);
}

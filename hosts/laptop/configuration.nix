{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    ../../modules/hyprland.nix
    ../../modules/greeter.nix
    ../../modules/pipewire.nix
    ../../modules/intel-gpu.nix
  ];

  networking.hostName = "laptop";

  # SSH disabled on laptop
  services.openssh.enable = false;

  # Laptop GUI home-manager modules
  home-manager.users.seeker.imports = [
    ../../modules/hyprland-home.nix
    ../../modules/waybar
    ../../modules/kitty
  ];

  # Laptop-specific user packages (appended to base list from home.nix)
  home-manager.users.seeker.home.packages = lib.mkAfter (with pkgs; [
    nerd-fonts.geist-mono
    obsidian
    brave
  ]);
}

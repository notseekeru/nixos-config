{ config, lib, pkgs, ... }:

{
  # ─── Boot ───
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # ─── Networking ───
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;

  # ─── Time ───
  time.timeZone = "Asia/Singapore";

  # ─── Nix ───
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  # ─── SSD TRIM (all hosts have SSDs) ───
  services.fstrim.enable = true;

  # ─── Tailscale (all hosts) ───
  services.tailscale.enable = true;

  # ─── User ───
  users.users.seeker = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # ─── Environment ───
  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    wget
    tree
  ];

  # ─── State ───
  system.stateVersion = "26.05";
}

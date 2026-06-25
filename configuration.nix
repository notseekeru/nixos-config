{ lib, pkgs, ... }:

{
  # ─── Boot ───
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # ─── Networking ───
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8" ];

  # ─── Tailscale ───
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

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

  # ─── User ───
  users.users.seeker = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # ─── Docker (all hosts) ───
  virtualisation.docker.enable = true;

  # ─── Environment ───
  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    wget
    tree
    docker-compose
  ];

  # ─── State ───
  system.stateVersion = "26.05";
}

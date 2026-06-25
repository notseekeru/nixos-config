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

  boot.extraModprobeConfig = ''
    options rtw88_core disable_lps_deep=y
    options rtw88_pci disable_aspm=y
  '';

  networking.networkmanager.wifi.powersave = false;

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

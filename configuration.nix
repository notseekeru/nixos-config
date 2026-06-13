{ config, lib, pkgs, ... }:

{	
  imports =
    [
      ./modules/vm.nix
      ./modules/hyprland.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/mnt/boot";

  # Override per-host in hosts/<name>/configuration.nix
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Singapore";

  nix.gc = {
  automatic = true;
  dates = "daily;";
  options = "--delete-older-than 1d";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.zsh.enable = true; # Added due to warning

  users.users.seeker = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      gh
    ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
  };
  
  environment.systemPackages = with pkgs; [
    wget
    tree
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "26.05";

}

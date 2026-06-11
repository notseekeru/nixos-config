{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Singapore";

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  users.users.seeker = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      gh
    ];
    shell = pkgs.zsh;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Crucial VMware Fixes:
    WLR_RENDERER = "pixman";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    AQ_DRIVERS = "pixman"; # Forces Hyprland's new backend engine to use safe graphics
  };

  virtualisation.vmware.guest.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    tree
    git
    kitty
    ghostty
    waybar
    wofi
    networkmanagerapplet
    dunst
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.displayManager.sddm.enable = false;
  services.displayManager.sddm.wayland.enable = false;

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  security.polkit.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "history" "npm" ];
    };

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}


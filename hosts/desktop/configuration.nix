{ config, lib, pkgs, ... }:

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

  boot.extraModprobeConfig = ''
    options rtw88_core disable_lps_deep=y
    options rtw88_usb disable_lps_deep=y
  '';

  networking.networkmanager.wifi.powersave = false;

  # 1. Kill off the broken default kernel modules completely
  boot.blacklistedKernelModules = [ "rtw88_8822bu" "rtw88_usb" "rtw88_core" ];

  # 2. FIXED: Pulled directly from pkgs.linuxPackages to stop the infinite evaluation loop
  boot.extraModulePackages = [
    pkgs.linuxPackages.rtl88x2bu
  ];

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
  home-manager.users.seeker.wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "DP-1,1920x1080@165,0x0,1.0"
      "HDMI-A-1,1920x1080@60,1920x0,1.0"
    ];

    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:HDMI-A-1"
    ];
  };

  # Desktop-specific user packages
  home-manager.users.seeker.home.packages = lib.mkAfter (with pkgs; [
    nerd-fonts.geist-mono
    brave
  ]);
}


{ config, pkgs, username, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/system/home-manager.nix
      ../../modules/system/sddm.nix
      #../../modules/home/plasma.nix
      ../../modules/home/hyprland.nix
      #../../modules/home/noctalia.nix
      #../../modules/home/dms.nix
      ../../modules/home/serpantinum.nix
      #../../modules/system/gamer.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
    cifs-utils

    sleek-grub-theme
    obsidian
    nemo

    proton-vpn
  ];

  fileSystems."/mnt/truenas/obsidian" = {
    device = "//42.0.69.27/obsidian";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/home/sean/.smb/truenas-smb-creds,uid=1000,gid=1000"];
  };

  services.fwupd.enable = true;

  time.hardwareClockInLocalTime = true;

  networking.hostName = "framework";
  networking.wireless.enable = true;

  services.printing.enable = true;

  hardware.alsa.enablePersistence = true;

home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ./monitor.lua;

system.stateVersion = "26.05"; 

}

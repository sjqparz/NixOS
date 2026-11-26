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
      ../../modules/home/dms.nix
      #../../modules/home/serpantinum.nix
      ../../modules/system/gamer.nix
    ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    cifs-utils
    vulkan-tools
    qimgv

    sleek-grub-theme
    obsidian
    
    nemo-with-extensions
    file-roller
    
    davinci-resolve
    zoom-us
    proton-vpn
    orca-slicer

    #ungoogled-chromium
  ];

  fileSystems."/mnt/truenas/dump" = {
    device = "//42.0.69.27/dump";
    fsType = "cifs";
    options = [
      "credentials=/home/sean/.smb/truenas-smb-creds"
      "uid=1000"
      "gid=1000"                       
      "x-systemd.automount"
      "noauto"
      "_netdev"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  fileSystems."/mnt/truenas/obsidian" = {
    device = "//42.0.69.27/obsidian";
    fsType = "cifs";
    options = [
      "credentials=/home/sean/.smb/truenas-smb-creds"
      "uid=1000"
      "gid=1000"                       
      "x-systemd.automount"
      "noauto"
      "_netdev"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = pkgs.sleek-grub-theme.override {
      withStyle = "dark";
    };
    extraEntries = ''
      menuentry "Windows" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        search --fs-uuid --set=root D04E-B4B1
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };

  time.hardwareClockInLocalTime = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "quarziale";

  services.printing.enable = true;

  hardware.alsa.enablePersistence = true;

  home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ./monitor.lua;

  services.displayManager.defaultSession = "hyprland";
  
system.stateVersion = "26.05"; 

}

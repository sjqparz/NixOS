{ config, pkgs, username, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/system/home-manager.nix
      ../../modules/system/sddm.nix
      ../../modules/home/plasma.nix
      ../../modules/home/hyprland.nix
      ../../modules/home/serpantinum.nix
     ../../modules/system/gamer.nix
    ];

  # Bootloader
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
  # networking.wireless.enable = true;

  services.printing.enable = true;

  hardware.alsa.enablePersistence = true;

  environment.systemPackages = with pkgs; [
    alsa-utils

    sleek-grub-theme
    obsidian
    nemo
    yazi #tui file manager

    
    #davinci-resolve
    #zoom-us
    #proton-vpn
    #orca-slicer
  ];
home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ./monitor.lua;

system.stateVersion = "26.05"; 

}

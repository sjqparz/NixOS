{ config, pkgs, username, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/system/home-manager.nix
      ../../modules/home/plasma.nix
      ../../modules/home/hyprland.nix
      ../../modules/system/sddm.nix
      ../../modules/system/gamer.nix
    ];

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  networking.hostName = "quarziale"; # Define your hostname.
  # networking.wireless.enable = true;

  #Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ./monitor.lua;

system.stateVersion = "26.05"; 

}

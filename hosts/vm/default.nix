# Manifest for this machine: what it imports, plus things that are
# specific to it (boot, hostname, extra apps).
{ pkgs, username, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/system/home-manager.nix
    ../../modules/home/plasma.nix
    ../../modules/home/hyprland.nix
    ../../modules/system/sddm.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
    theme = pkgs.sleek-grub-theme.override {
      withStyle = "dark";
    };
    #gfxmodeEfi = "1440x2560";
  };

  # Must match the name in flake.nix so `nixos-rebuild --flake <path>` finds this host.
  networking.hostName = "vm";

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    sleek-grub-theme
  ];

  home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig =
    builtins.readFile ./monitor.lua;

  system.stateVersion = "26.05";
}

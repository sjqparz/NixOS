# Settings shared by every machine: system-level (NixOS) and user-level (Home Manager).
{ pkgs, username, ... }:
{
  # ---------- System level (NixOS) ----------
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    git
    wget
    nautilus
    btop
    fastfetch

    vlc
    ffmpeg-full
    qimgv
    feishin

    remmina
    libreoffice
  ];

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User account. zsh is enabled here so it is a valid login shell
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];


  #APPS--------------------------------------------

  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    policies = {
      DisableTelemetry   = true;
      DisableFormHistory = true;
      DisplayMenuBar     = "never";
      OfferToSaveLogins  = false;

      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        # Keys must be the add-on IDs (see about:support in Firefox), not nicknames.
        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url       = moz "bitwarden-password-manager";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };
      };
    };
  };


  # ---------- User level (Home Manager) ----------
  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "26.05";

    #TERMINAL---------------------------------------
    programs.kitty = {
      enable = true;
      settings.background_opacity = "0.90";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;

      history = {
        size = 50000;
        save = 50000;
        ignoreAllDups = true;
        share = true;
      };

      # Terminal shortcuts
      shellAliases = {
        ll = "ls -lah";
        ".." = "cd ..";
        rebuild  = "sudo nixos-rebuild switch --flake /home/sean/nixos#vm";
        build    = "sudo nixos-rebuild build --flake /home/sean/nixos#vm";
        update   = "sudo nix flake update";
        trashman = "sudo nix-collect-garbage";
      };

      #IDK WTF this is, some type of zsh compltetion settings? Thanks Claude!
      initContent = ''
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      presets = [ "nerd-font-symbols" ];
    };

    programs.vscodium = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jeff-hykin.better-nix-syntax
        ];
        userSettings = {
          "workbench.colorTheme" = "Monokai Dimmed";
        };
      };
    };
  };
}
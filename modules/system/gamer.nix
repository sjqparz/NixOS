{ pkgs, ... }:
{
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.gamescope.capSysNice = false;
    programs.steam.gamescopeSession = {
      enable = true;
      env = {
        WLR_RENDERER = "vulkan";
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        ENABLE_HDR_WSI = "1";
        WINE_FULLSCREEN_FSR = "1";
        # Games allegedly prefer X11
        #SDL_VIDEODRIVER = "x11";
      };

      args = [
        "--xwayland-count 1"
       #"--expose-wayland"

       "-e" # Enable steam integration

       "--adaptive-sync"
       "--hdr-enabled"
       "--hdr-itm-enable"
      ];
    };


    environment.systemPackages = with pkgs; [
        steam
        gamemode
        protonplus
        faugus-launcher
        discord
    ];
}
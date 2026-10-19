{ pkgs, ... }:
{

#--------COMMANDS FOR STEAM--------#
#All GAMES:
#  gamemoderun %command%

#HDR GAMES:
#  PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1

    #hardware.graphics = {
      #enable = true;
      #enable32Bit = true;
    #};
    
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession = {
        enable = true;
        env = {
          WLR_RENDERER = "vulkan";
          DXVK_HDR = "1";
        };
#        args = [
         #"--xwayland-count 1"
#         "--adaptive-sync"
#         "--hdr-enabled"
         #"--hdr-debug-force-output"
#        ];
      };
    };

    programs.gamescope = {
      enable     = true;
      #enableWsi  = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
        protonplus
        faugus-launcher
        discord
    ];
}

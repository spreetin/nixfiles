{ config, lib, ... }:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "gaming" cfg.profiles) {
    hardware = {
      xone.enable = true;
      steam-hardware.enable = true;
    };
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
  };
}

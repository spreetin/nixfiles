{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.spreetin;
in
{
  config = mkIf (elem "mediaplayers" cfg.home.profiles) {
    home.packages = with pkgs; [
      feishin
      mpv
      mpvScripts.mpris
      plexamp
      plex-desktop
      spotify
      vlc
      yt-dlp
    ];
  };
}

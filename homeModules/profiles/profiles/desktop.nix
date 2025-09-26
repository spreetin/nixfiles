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
  config = mkIf (elem "desktop" cfg.home.profiles) {
    home.packages = with pkgs; [
      ags
      anki
      astal.battery
      bitwarden-desktop
      calibre
      dia
      ffmpeg
      protonvpn-gui
      openrgb-with-all-plugins
      solaar
      filezilla
      wireguard-tools
    ];
  };
}

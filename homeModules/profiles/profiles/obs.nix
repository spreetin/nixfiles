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
  config = mkIf (elem "obs" cfg.home.profiles) {
    home.packages = with pkgs; [
      obs-studio
      obs-studio-plugins.obs-mute-filter
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}

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
  config = mkIf (elem "images" cfg.home.profiles) {
    home.packages = with pkgs; [
      gimp3-with-plugins
      imagemagick
      image-roll
      krita
    ];
  };
}

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
  config = mkIf (elem "gaming" cfg.home.profiles) {
    home.packages = with pkgs; [
      bottles
      lutris
      mangohud
      openmw
      openttd
      protonplus
      protonup-qt
      wine
      winetricks
    ];
    programs.mangohud.enable = true;
  };
}

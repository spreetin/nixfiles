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
  config = mkIf (elem "distrobox" cfg.home.profiles) {
    home.packages = with pkgs; [
      distrobox
      distrobox-tui
      distroboxshelf
    ];
  };
}

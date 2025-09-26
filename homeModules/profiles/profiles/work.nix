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
  config = mkIf (elem "work" cfg.home.profiles) {
    home.packages = with pkgs; [
      teams-for-linux
      anydesk
    ];
  };
}

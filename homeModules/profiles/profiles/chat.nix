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
  config = mkIf (elem "chat" cfg.home.profiles) {
    home.packages =
      with pkgs;
      [
        discordo
        gurk-rs
      ]
      ++ (
        if (elem "desktop" cfg.home.profiles) then
          [
            discord
            signal-desktop
            zoom-us
          ]
        else
          [ ]
      );
  };
}

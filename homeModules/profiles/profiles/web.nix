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
  config = mkIf (elem "web" cfg.home.profiles) {
    home.packages =
      with pkgs;
      (
        [
          elinks
        ]
        ++ (
          if (elem "desktop" cfg.home.profiles) then
            [
              browsh
              librewolf
              chromium
            ]
          else
            [ ]
        )
      );
  };
}

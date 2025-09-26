{ config, lib, ... }:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    home.file."${config.xdg.configHome}/swaync" = {
      source = ../../../configs/swaync;
      recursive = true;
    };
  };
}

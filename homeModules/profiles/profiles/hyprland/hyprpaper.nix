{ config, lib, ... }:
let
  xdg = config.xdg;
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = "${xdg.configHome}/hypr/wallpaper/wallpaper.jpg";
        wallpaper = ", ${xdg.configHome}/hypr/wallpaper/wallpaper.jpg";
      };
    };
  };
}

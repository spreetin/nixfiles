{ config, lib, ... }:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = {
          timeout = 1800;
          on-timeout = "loginctl lock-session";
        };
      };
    };
  };
}

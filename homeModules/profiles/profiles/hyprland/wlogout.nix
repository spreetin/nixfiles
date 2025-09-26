{ config, lib, ... }:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    home.file."${config.xdg.configHome}/wlogout/scripts" = {
      source = ../../../scripts/wlogout;
      executable = true;
      recursive = true;
    };
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "pidof hyprlock || hyprlock -q";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "logout";
          action = "sleep 1; hyprctl dispatch exit";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
      ];
    };
  };
}

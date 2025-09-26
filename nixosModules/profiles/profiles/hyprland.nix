{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.windowManagers) {
    programs = {
      hyprland.enable = true;
      xfconf.enable = true;
      nm-applet.indicator = true;
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          mousepad
          tumbler
          thunar-archive-plugin
          thunar-volman
          thunar-vcs-plugin
          thunar-media-tags-plugin
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      blueman
      xdg-desktop-portal-hyprland
    ];
  };
}

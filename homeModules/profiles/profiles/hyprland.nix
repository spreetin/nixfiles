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
  imports = [
    ./hyprland/hyprland.nix
    ./hyprland/hypridle.nix
    ./hyprland/hyprlock.nix
    ./hyprland/hyprpaper.nix
    ./hyprland/waybar.nix
    ./hyprland/wlogout.nix
    ./hyprland/swaync.nix
  ];

  config = mkIf (elem "hyprland" cfg.home.windowManager) {
    home.packages = with pkgs; [
      brightnessctl
      cliphist
      hyprcursor
      hypridle
      hyprlock
      hyprpaper
      hyprpicker
      hyprshot
      libappindicator
      libiconv
      libnotify
      networkmanagerapplet
      nwg-displays
      pamixer
      pavucontrol
      playerctl
      rofi
      rose-pine-hyprcursor
      slurp
      swappy
      swaynotificationcenter
      swww
      wl-clipboard
      wlogout
    ];

    home.file."${config.xdg.configHome}/hypr/scripts" = {
      source = ../../scripts/hypr;
      executable = true;
    };
    home.file."${config.xdg.configHome}/hypr/wallpaper".source = ../../assets/wallpaper;

    gtk = {
      enable = true;
      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
      font = {
        name = "Sans";
        size = 12;
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
      ];
    };
  };
}

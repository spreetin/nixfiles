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
  config = lib.mkIf (lib.elem "desktop" cfg.profiles) {
    boot = {
      plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = with pkgs; [
          nixos-bgrt-plymouth
        ];
      };
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      loader.timeout = 0;
    };
    environment.systemPackages = with pkgs; [
      glxinfo
      sddm-chili-theme
      vulkan-tools
    ];
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
    programs = {
      xwayland.enable = true;
    };
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "chili";
        };
      };
      xserver = {
        xkb = {
          layout = "se,us";
          variant = "";
          options = "grp:alt_shift:toggle";
        };
      };
      blueman.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    spreetin.windowManagers = [ "hyprland" ];
  };
}

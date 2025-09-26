{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.spreetin;
in
{
  imports = [
    ./profiles/common.nix
    ./profiles/desktop.nix
    ./profiles/flatpak.nix
    ./profiles/gaming.nix
    ./profiles/hyprland.nix
    ./profiles/kvm-host.nix
    ./profiles/server.nix
    ./profiles/sound.nix
    ./profiles/users.nix
    ./profiles/xdg.nix
  ];

  options.spreetin = {
    profiles = mkOption {
      type = types.listOf (
        types.enum [
          "desktop"
          "flatpak"
          "gaming"
          "kvm-host"
          "printing"
          "server"
          "sound"
        ]
      );
    };
    windowManagers = mkOption {
      type = types.listOf (
        types.enum [
          "hyprland"
        ]
      );
      default = [ ];
    };
  };

  config = {
    boot.kernelPackages =
      if (elem "gaming" cfg.profiles) then pkgs.linuxPackages_xanmod_latest else pkgs.linuxPackages;

    services.printing.enable = mkIf (elem "printing" cfg.profiles) true;

    programs = {
      virt-manager.enable = mkIf ((elem "desktop" cfg.profiles) && (elem "kvm-host" cfg.profiles)) true;
    };
  };
}

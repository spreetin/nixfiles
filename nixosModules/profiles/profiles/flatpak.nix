{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.spreetin;
in
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  config = lib.mkIf (lib.elem "flatpak" cfg.profiles) {
    services = {
      flatpak = {
        enable = true;
        packages = lib.optional (lib.elem "desktop" cfg.profiles) "de.mediathekview.MediathekView";
      };
    };
    systemd.services.flatpak-repo = {
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "kvm-host" cfg.profiles) {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [ pkgs.virtiofsd ];
      };
      spiceUSBRedirection.enable = true;
    };
  };
}

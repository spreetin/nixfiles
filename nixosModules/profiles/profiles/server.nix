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
  config = lib.mkIf (lib.elem "server" cfg.profiles) {

  };
}

inputs:
{
  config,
  lib,
  ...
}:
with lib;
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];
  options.spreetin = {
    themes = {
      catppuccin = mkOption {
        type = types.bool;
        default = true;
        description = "Enable catppuccin themeing";
      };
    };
  };
}

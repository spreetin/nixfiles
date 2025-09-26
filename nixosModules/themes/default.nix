{ config, lib, ... }:
with lib;
{
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

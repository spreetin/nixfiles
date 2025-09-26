{ config, lib, ... }:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fG" = "live_grep";
        };
        extensions = {
          fzf-native.enable = true;
          undo.enable = true;
        };
      };
    };
  };
}

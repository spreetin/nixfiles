{ config, lib, ... }:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
      };
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      treesitter-refactor.enable = true;
      ts-autotag.enable = true;
      ts-context-commentstring.enable = true;
    };
  };
}

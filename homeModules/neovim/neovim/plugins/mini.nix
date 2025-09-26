{ config, lib, ... }:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    plugins = {
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
            search_method = "cover_or_next";
          };
          bufremove = {
            silent = true;
          };
          comment = {
          };
          indentscope = {
          };
          pairs = {
          };
          surround = {
            n_lines = 100;
          };
        };
      };
    };
  };
}

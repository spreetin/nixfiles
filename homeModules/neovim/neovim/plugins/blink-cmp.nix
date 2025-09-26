{ config, lib, ... }:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    plugins = {
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "super-tab";
            "<C-CR>" = [
              "select_and_accept"
              "fallback"
            ];
          };
          signature.enabled = true;
          sources = {
            providers = {
              ripgrep = {
                async = true;
                module = "blink-ripgrep";
                name = "Ripgrep";
                score_offset = 100;
                opts = {
                  project_root_marker = ".git";
                  search_casing = "--ignore-case";
                };
              };
            };
            default = [
              "lsp"
              "path"
              #"snippets"
              "buffer"
              "ripgrep"
            ];
          };
        };
      };
      blink-ripgrep.enable = true;
    };
  };
}

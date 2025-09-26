{
  lib,
  config,
  ...
}:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    plugins = {
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
          show_keys = true;
          spec = [
            {
              __unkeyed-1 = "<leader>c";
              group = "Code";
              icon = " ";
              mode = "n";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "Git/LSP";
              icon = " ";
              mode = "n";
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "Find";
              icon = " ";
              mode = "n";
            }
            {
              __unkeyed-1 = "<leader>s";
              group = "Search";
              icon = " ";
              mode = "n";
            }
            {
              __unkeyed-1 = "<leader>d";
              group = "Debug";
              icon = " ";
              mode = "n";
            }
            {
              __unkeyed-1 = "<leader>u";
              group = "Clear";
              icon = " ";
              mode = "n";
            }
          ];
        };
      };
    };
  };
}

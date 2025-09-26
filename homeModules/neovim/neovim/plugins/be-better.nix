{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

let
  be-better = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-be-better";
    version = "2025-08-09";
    src = inputs.vim-be-better;
    meta.homepage = "https://github.com/szymonwilczek/vim-be-better";
  };
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    extraPlugins = [ be-better ];
  };
}

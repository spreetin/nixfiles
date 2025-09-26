{ config, lib, ... }:
with lib;
let
  cfg = config.spreetin.neovim;
in
{
  imports = [
    ./plugins/be-better.nix
    ./plugins/blink-cmp.nix
    ./plugins/conform.nix
    ./plugins/dap.nix
    ./plugins/lint.nix
    ./plugins/mini.nix
    ./plugins/snacks.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/which-key.nix

  ];
  programs.nixvim = mkIf cfg.enable {
    plugins = {
      lspconfig.enable = true;
      clangd-extensions.enable = mkIf ((elem "c" cfg.languages) || (elem "c++" cfg.languages)) true;
      actions-preview.enable = true;
      bufferline.enable = true;
      cmake-tools.enable = mkIf (elem "cmake" cfg.languages) true;
      #cmp = {
      #  enable = true;
      #  autoEnableSources = true;
      #  settings.sources = [
      #    { name = "buffer"; }
      #    { name = "nvim_lsp"; }
      #    { name = "treesitter"; }
      #  ];
      #};
      dashboard.enable = true;
      dial.enable = true;
      flash.enable = true;
      friendly-snippets.enable = true;
      gitsigns.enable = true;
      grug-far.enable = true;
      illuminate.enable = true;
      inc-rename.enable = true;
      indent-blankline.enable = true;
      lazygit.enable = true;
      lualine.enable = true;
      lz-n = {
        enable = true;
        autoLoad = true;
      };
      neo-tree.enable = true;
      nix-develop.enable = true;
      nix.enable = true;
      noice.enable = true;
      notify.enable = true;
      nui.enable = true;
      nvim-autopairs.enable = true;
      #nvim-snippets.enable = true;
      nvim-surround.enable = true;
      persistence.enable = true;
      spectre.enable = true;
      trouble.enable = true;
      undotree.enable = true;
      web-devicons.enable = true;
    };
  };
}

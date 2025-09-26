{ config, lib, ... }:
with lib;
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = mkIf cfg.enable {
    globals = {
      mapleader = " ";
      localleader = "\\";
    };
    opts = {
      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
      mouse = "a";
      # Tabs
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      # UI
      number = true;
      relativenumber = true;
      cursorline = true;
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      signcolumn = "yes";
      colorcolumn = "100";
      # Search
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      # Files
      backup = false;
      writebackup = false;
      swapfile = false;
      undofile = true;
      undodir.__raw = "vim.fs.normalize('~/.vim/undodir')";
      autoread = true;
      autowrite = false;
      # Behaviour
      backspace = "indent,eol,start";
      encoding = "UTF-8";
    };
    clipboard = {
      register = "unnamedplus";
      providers = {
        xclip.enable = true;
        wl-copy.enable = true;
      };
    };
  };
}

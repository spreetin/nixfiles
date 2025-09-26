{ lib, config, ... }:
with lib;
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = mkIf cfg.enable {
    keymaps = [
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = ":resize -2<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = ":resize +2<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = ":vertical resize +2<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>t";
        action = ":ToggleTerm<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "toggle terminal";
        };
      }
      {
        mode = "n";
        key = "<leader><space>";
        action.__raw = ''function() Snacks.picker.smart() end'';
        options.desc = "Smart Find Files";
      }
      {
        mode = "n";
        key = "<leader>,";
        action.__raw = ''function() Snacks.picker.buffers() end'';
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>n";
        action.__raw = ''function() Snacks.notifications() end'';
        options.desc = "Notification History";
      }
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = ''function() Snacks.explorer() end'';
        options.desc = "File Explorer";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action.__raw = ''function() Snacks.picker.buffers() end'';
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action.__raw = ''function() Snacks.picker.files({cwd = vim.fn.stdpath("config")}) end'';
        options.desc = "Find Config File";
      }
    ]
    ++ lib.optional ((lib.elem "c" cfg.languages) || (lib.elem "c++" cfg.languages)) {
      mode = "n";
      key = "<F4>";
      action = "<cmd>ClangdSwitchSourceHeader";
      options.desc = "Switch Header/Source";
    };
  };
}

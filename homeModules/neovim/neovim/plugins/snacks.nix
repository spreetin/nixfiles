{
  config,
  lib,
  ...
}:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    keymaps = [
      # Pickers
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
      {
        mode = "n";
        key = "<leader>ff";
        action.__raw = ''function() Snacks.picker.files() end'';
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action.__raw = ''function() Snacks.picker.git_files() end'';
        options.desc = "Find Git Files";
      }
      {
        mode = "n";
        key = "<leader>fp";
        action.__raw = ''function() Snacks.picker.projects() end'';
        options.desc = "Projects";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action.__raw = ''function() Snacks.picker.recent() end'';
        options.desc = "Recent";
      }
      # LSP
      {
        mode = "n";
        key = "gd";
        action.__raw = ''function() Snacks.picker.lsp_definitions() end'';
        options.desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "<F3>";
        action.__raw = ''function() Snacks.picker.lsp_definitions() end'';
        options.desc = "Goto Defintion";
      }
      {
        mode = "n";
        key = "gD";
        action.__raw = ''function() Snacks.picker.lsp_declarations() end'';
        options.desc = "Goto Declaration";
      }
      {
        mode = "n";
        key = "<F2>";
        action.__raw = ''function() Snacks.picker.lsp_declarations() end'';
        options.desc = "Goto Declaration";
      }
      {
        mode = "n";
        key = "gr";
        action.__raw = ''function() Snacks.picker.lsp_references() end'';
        options = {
          nowait = true;
          desc = "References";
        };
      }
      {
        mode = "n";
        key = "gI";
        action.__raw = ''function() Snacks.picker.lsp_implementations() end'';
        options.desc = "Goto Implementation";
      }
      {
        mode = "n";
        key = "gy";
        action.__raw = ''function() Snacks.picker.lsp_type_definitions() end'';
        options.desc = "Goto T[y]pe Definition";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action.__raw = ''function() Snacks.picker.lsp_symbols() end'';
        options.desc = "LSP Symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action.__raw = ''function() Snacks.picker.lsp_workspace_symbols() end'';
        options.desc = "LSP Workspace Symbols";
      }
      {
        mode = "n";
        key = "<leader>n";
        action.__raw = ''function() Snacks.notifier.show_history() end'';
        options.desc = "Notification History";
      }
      {
        mode = "n";
        key = "<leader>cR";
        action.__raw = ''function() Snacks.rename.rename_file() end'';
        options.desc = "Rename File";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action.__raw = ''function() Snacks.lazygit() end'';
        options.desc = "Lazygit";
      }
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = ''function() Snacks.notifier.hide() end'';
        options.desc = "Dismiss All Notifications";
      }
      {
        mode = "n";
        key = "<leader>st";
        action.__raw = ''function() Snacks.picker.todo_comments() end'';
        options.desc = "Todo";
      }
      {
        mode = "n";
        key = "<leader>sT";
        action.__raw = ''function() Snacks.picker.todo_comments({keywords = { "TODO", "FIX", "FIXME"}}) end'';
        options.desc = "Todo/Fix/Fixme";
      }
      {
        mode = "n";
        key = "<leader>su";
        action.__raw = ''function() Snacks.picker.undo() end'';
        options.desc = "Undo Tree";
      }
      {
        mode = "n";
        key = "<leader>sq";
        action.__raw = ''function() Snacks.picker.qflist() end'';
        options.desc = "Quickfix List";
      }
      {
        mode = "n";
        key = "<leader>si";
        action.__raw = ''function() Snacks.picker.icons() end'';
        options.desc = "Icons";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action.__raw = ''function() Snacks.picker.diagnostics() end'';
        options.desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sB";
        action.__raw = ''function() Snacks.picker.grep_buffers() end'';
        options.desc = "Grep Open Buffers";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action.__raw = ''function() Snacks.picker.grep() end'';
        options.desc = "Grep";
      }
    ];
    plugins.snacks.enable = true;
  };
}

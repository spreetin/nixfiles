{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = lib.mkIf cfg.enable {
    extraPackages = with pkgs; [
      vscode-extensions.vadimcn.vscode-lldb
    ];
    plugins = {
      dap.enable = true;
      dap-lldb = {
        enable = true;
        settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      };
      dap-python.enable = true;
      dap-ui = {
        enable = true;
        luaConfig.post = ''
          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        '';
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>DapContinue<CR>";
        options = {
          silent = true;
          desc = "Run Debugger";
        };
      }
      {
        mode = "n";
        key = "<F9>";
        action = "<cmd>DapToggleBreakpoint<CR>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<F10>";
        action = "<cmd>DapStepOver<CR>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<F11>";
        action = "<cmd>DapStepInto<CR>";
        options = {
          silent = true;
          desc = "Step Into";
        };
      }
      {
        mode = "n";
        key = "<F12>";
        action = "<cmd>DapStepOut<CR>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>DapContinue<CR>";
        options = {
          silent = true;
          desc = "Run Debugger";
          #icon = " ";
        };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require'dap'.run_last()<CR>";
        options = {
          silent = true;
          desc = "Run Last Debug";
          #icon = " ";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = "<cmd>DapToggleBreakpoint<CR>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
          #icon = " ";
        };
      }
    ];
  };
}

{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.spreetin.neovim;
in
{
  programs.nixvim = mkIf cfg.enable {
    extraPackages =
      with pkgs;
      [
        nixfmt-rfc-style
      ]
      ++ optional (elem "python" cfg.languages) black
      ++ optional (elem "cmake" cfg.languages) cmake-format
      ++ optional (elem "go" cfg.languages) gofumpt
      ++ optional (elem "rust" cfg.languages) rustfmt
      ++ optional (elem "lua" cfg.languages) stylua
      ++ optional ((elem "c" cfg.languages) || (elem "c++" cfg.languages)) vimPlugins.vim-clang-format
      ++ optional (elem "clojure" cfg.languages) zprint
      ++ optional (elem "zig" cfg.languages) zigfmt;
    plugins.conform-nvim = {
      enable = true;
      settings = {
        lsp_format = "fallback";
        formatters_by_ft = {
          c = [ ] ++ optional (elem "c" cfg.languages) "clang_format";
          clojure = [ ] ++ optional (elem "clojure" cfg.languages) "zprint";
          cmake = [ ] ++ optional (elem "cmake" cfg.languages) "cmake_format";
          cpp = [ ] ++ optional (elem "c++" cfg.languages) "clang_format";
          css = [ ] ++ optional (elem "css" cfg.languages) "prettierd";
          go = [ ] ++ optional (elem "go" cfg.languages) "gofumpt";
          haskell = [ ] ++ optional (elem "haskell" cfg.languages) "hlindent";
          html = [ ] ++ optional (elem "html" cfg.languages) "prettierd";
          javascript = [ ] ++ optional (elem "javascript" cfg.languages) "prettierd";
          json = [ ] ++ optional (elem "json" cfg.languages) "prettierd";
          lua = [ ] ++ optional (elem "lua" cfg.languages) "stylua";
          markdown = [ ] ++ optional (elem "markdown" cfg.languages) "prettierd";
          nix = [ "nixfmt" ];
          python = [ ] ++ optional (elem "python" cfg.languages) "black";
          rust = [ ] ++ optional (elem "rust" cfg.languages) "rustfmt";
          yaml = [ ] ++ optional (elem "yaml" cfg.languages) "prettierd";
          zig = [ ] ++ optional (elem "zig" cfg.languages) "zigfmt";
        };
        format_on_save = ''
          {
            timeout_ms = 200,
            lsp_fallback = true
          }
        '';
      };
    };
  };
}

{
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
    lsp.servers.asm_lsp.enable = mkIf (elem "asm" cfg.languages) true;
    lsp.servers.bashls.enable = mkIf (elem "bash" cfg.languages) true;
    lsp.servers.clangd.enable = mkIf ((elem "c" cfg.languages) || (elem "c++" cfg.languages)) true;
    lsp.servers.clojure_lsp.enable = mkIf (elem "clojure" cfg.languages) true;
    lsp.servers.cmake.enable = mkIf (elem "cmake" cfg.languages) true;
    lsp.servers.cssls.enable = mkIf (elem "css" cfg.languages) true;
    lsp.servers.hls.enable = mkIf (elem "haskell" cfg.languages) true;
    lsp.servers.java_language_server.enable = mkIf (elem "java" cfg.languages) true;
    lsp.servers.jsonls.enable = mkIf (elem "json" cfg.languages) true;
    lsp.servers.lua_ls.enable = mkIf (elem "lua" cfg.languages) true;
    lsp.servers.markdown_oxide.enable = mkIf (elem "markdown" cfg.languages) true;
    lsp.servers.nixd.enable = true;
    lsp.servers.pylsp.enable = mkIf (elem "python" cfg.languages) true;
    lsp.servers.rust_analyzer.enable = mkIf (elem "rust" cfg.languages) true;
    lsp.servers.sqls.enable = mkIf (elem "sql" cfg.languages) true;
    lsp.servers.ts_ls.enable = mkIf (elem "typescript" cfg.languages) true;
    lsp.servers.yamlls.enable = mkIf (elem "yaml" cfg.languages) true;
    lsp.servers.zls.enable = mkIf (elem "zig" cfg.languages) true;
  };
}

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
      [ ]
      ++ optional (elem "clojure" cfg.languages) clj-kondo
      ++ optional (elem "cmake" cfg.languages) cmake-lint
      ++ optional ((elem "c" cfg.languages) || (elem "c++" cfg.languages)) cppcheck
      ++ optional (elem "go" cfg.languages) golangci-lint
      ++ optional (elem "haskell" cfg.languages) hlint
      ++ optional (elem "html" cfg.languages) html-tidy
      ++ optional (elem "lua" cfg.languages) luajitPackages.luacheck
      ++ optional (elem "markdown" cfg.languages) markdownlint-cli
      ++ optional (elem "javascript" cfg.languages) nodePackages.jshint
      ++ optional (elem "json" cfg.languages) nodePackages.jsonlint
      ++ optional (elem "python" cfg.languages) pylint
      ++ optional (elem "yaml" cfg.languages) yamllint;
    plugins.lint = {
      enable = true;
      lintersByFt = {
        c = mkIf (elem "c" cfg.languages) [ "cppheck" ];
        clojure = mkIf (elem "clojure" cfg.languages) [ "clj-kondo" ];
        cmake = mkIf (elem "cmake" cfg.languages) [ "cmakelint" ];
        cpp = mkIf (elem "c++" cfg.languages) [ "cppcheck" ];
        go = mkIf (elem "go" cfg.languages) [ "golangcilint" ];
        haskell = mkIf (elem "haskell" cfg.languages) [ "hlint" ];
        html = mkIf (elem "html" cfg.languages) [ "tidy" ];
        javascript = mkIf (elem "javascript" cfg.languages) [ "jshint" ];
        json = mkIf (elem "json" cfg.languages) [ "jsonlint" ];
        lua = mkIf (elem "lua" cfg.languages) [ "luacheck" ];
        markdown = mkIf (elem "markdown" cfg.languages) [ "markdownlint" ];
        nix = [ "nix" ];
        python = mkIf (elem "python" cfg.languages) [ "pylint" ];
        yaml = mkIf (elem "yaml" cfg.languages) [ "yamllint" ];
      };
    };
  };
}

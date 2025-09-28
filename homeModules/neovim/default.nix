inputs:
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
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./neovim/config.nix
    ./neovim/plugins.nix
    ./neovim/keybinds.nix
    ./neovim/lsp.nix
  ];

  options.spreetin.neovim = {
    enable = mkEnableOption "Enable neovim config";
    languages = mkOption {
      type = types.listOf (
        types.enum [
          "asm"
          "bash"
          "c"
          "c++"
          "clojure"
          "cmake"
          "css"
          "go"
          "haskell"
          "html"
          "java"
          "javascript"
          "json"
          "lua"
          "markdown"
          "python"
          "rust"
          "sql"
          "typescript"
          "yaml"
          "zig"
        ]
      );
      description = "Languages to support for LSP and formatting";
      default = [
        "bash"
        "c"
        "c++"
        "css"
        "json"
        "lua"
        "markdown"
        "python"
        "sql"
        "yaml"
      ];
    };
  };
  config.programs.nixvim = mkIf cfg.enable {

    enable = true;

    withRuby = false;
    extraPackages = with pkgs; [
      fzf
      lazygit
      ripgrep
    ];
    colorschemes.catppuccin.enable = true;
    colorscheme = "catppuccin";
  };
}

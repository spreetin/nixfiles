{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.spreetin.zsh;
in
{
  options.spreetin.zsh = {
    enable = mkEnableOption "Enable zsh config";
    imetall = mkOption {
      type = types.bool;
      default = false;
    };
    tmux = mkOption {
      type = types.bool;
      default = true;
      description = "Enable tmux support";
    };
    direnv = mkOption {
      type = types.bool;
      default = true;
      description = "Enable direnv support";
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      oh-my-zsh
      zsh-syntax-highlighting
      fd
      fzf
    ];
  };
  config.programs = mkIf cfg.enable {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "af-magic";
        plugins = [
          "git"
          "ssh"
          "sudo"
          "web-search"
          "extract"
          "colored-man-pages"
          "compleat"
          "fzf"
          "vi-mode"
          "direnv"
        ];
      };
      shellAliases = {
        icat = "kitten icat";
        sshk = "kitten ssh";
        ls = "eza";
        cat = "bat";
      }
      // mkIf cfg.imetall {
        p_kina = "ssh -L 8006:10.2.1.3:8006 imetall";
        p_sovjet = "ssh -L 8006:10.2.1.4:8006 imetall";
        p_kuba = "ssh -L 8006:10.2.1.2:8006 imetall";
        p_kvm = "ssh -L 8001:10.2.1.100:443 imetall";
      };
      shellGlobalAliases = {
        "--help" = "--help 2>&1 | bat --language=help --style=plain";
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
      colors = "auto";
      theme = "catppuccin";
    };
    bat = {
      enable = true;
    };
    tmux = mkIf cfg.tmux {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      sensibleOnTop = true;
      shell = "${pkgs.zsh}/bin/zsh";
    };
    direnv = mkIf cfg.direnv {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

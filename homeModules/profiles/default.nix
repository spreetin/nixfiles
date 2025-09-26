{
  lib,
  config,
  nixosOptions,
  inputs,
  hostname,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.spreetin;
  optnixLib = inputs.optnix.mkLib pkgs;
in
{
  imports = [
    inputs.optnix.homeModules.optnix
    ./profiles/audio.nix
    ./profiles/chat.nix
    ./profiles/desktop.nix
    ./profiles/distrobox.nix
    ./profiles/gaming.nix
    ./profiles/hyprland.nix
    ./profiles/images.nix
    ./profiles/mediaplayers.nix
    ./profiles/obs.nix
    ./profiles/office.nix
    ./profiles/server.nix
    ./profiles/terminals.nix
    ./profiles/web.nix
    ./profiles/work.nix
  ];

  options.spreetin.home = {
    profiles = mkOption {
      type = types.listOf (
        types.enum (
          [
            "desktop"
            "server"
            "gaming"
            "work"
            "obs"
            "audio"
            "mediaplayers"
            "office"
            "images"
            "chat"
            "web"
            "distrobox"
          ]
          ++ (if (builtins.hasAttr "profiles" cfg) then cfg.profiles.type.enum else [ ])
        )
      );
    };
    windowManager = mkOption {
      type = types.listOf (
        if (builtins.hasAttr "windowManager" cfg) then cfg.windowManager else types.enum [ "hyprland" ]
      );
      default = (
        if (builtins.hasAttr "windowManager" cfg) then
          cfg.windowManager
        else
          (if (elem "desktop" cfg.home.profiles) then [ "hyprland" ] else [ ])
      );
      description = "What window manager to configure";
    };
    terminals = mkOption {
      type = types.listOf (
        types.enum [
          "kitty"
        ]
      );
      default = (if (elem "desktop" cfg.home.profiles) then [ "kitty" ] else [ ]);
      description = "Terminal applications to configure";
    };
    themes.catppuccin = mkOption {
      type = types.bool;
      default = (if (builtins.hasAttr "themes" cfg) then config.spreetin.themes.catppuccin else true);
    };
  };

  config = {
    spreetin = mkIf (builtins.hasAttr "profiles" cfg) {
      home.profiles = cfg.profiles;
      zsh = {
        enable = mkDefault true;
        imetall = mkDefault true;
      };
      neovim.enable = mkDefault true;
    };
    catppuccin = mkIf cfg.home.themes.catppuccin {
      bat.enable = true;
      btop.enable = true;
      cursors.enable = true;
      firefox.enable = true;
      fzf.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      lazygit.enable = true;
      librewolf.enable = true;
      mpv.enable = true;
      nvim.enable = true;
      obs.enable = true;
      swaync.enable = true;
      tmux.enable = true;
      wlogout.enable = true;
      yazi.enable = true;
      zsh-syntax-highlighting.enable = true;
    };
    xdg.enable = true;
    home = {
      username = "david";
      homeDirectory = "/home/david";
      stateVersion = "25.05";
      file = {
        "${config.xdg.configHome}/ags".source = ../ags;
        "${config.xdg.configHome}/scripts" = {
          source = ../scripts;
          recursive = true;
          executable = true;
        };
      };
    };
    programs = {
      git = {
        enable = true;
        userName = "David Falk";
        userEmail = "spreetin@protonmail.com";
      };
      yazi = {
        enable = mkDefault true;
        plugins = with pkgs.yaziPlugins; {
          git = git;
          ouch = ouch;
          glow = glow;
          mount = mount;
          chmod = chmod;
          yatline = yatline;
          lazygit = lazygit;
          mediainfo = mediainfo;
          relative-motions = relative-motions;
        };
      };
      optnix = {
        enable = mkDefault true;
        settings = {
          min_score = 3;
          scopes = {
            desktop = {
              description = "NixOS config";
              options-list-file = optnixLib.mkOptionsList { options = nixosOptions; };
              evaluator = "nix eval /home/${config.home.username}/dotfiles/#nixosConfigurations.${hostname}.config.{{ .Option }}";
            };
            home-manager = {
              description = "home-manager config";
              options-list-file = optnixLib.mkOptionsList {
                inherit options;
                transform =
                  o:
                  o
                  // {
                    name = lib.removePrefix "home-manager.users.${config.home.username}." o.name;
                  };
              };
            };
            #evaluator = "";
          };
        };
      };
    };
    home.packages = with pkgs; [
      gnutar
      p7zip
      unzip
      xz
      zip
      cloc
      code-cursor
      cppcheck
      git-crypt
      lazygit
      dnsutils
      nettools
      nmap
      sshfs
      traceroute
      wget
      baobab
      btop
      iftop
      iotop
      lsof
      ncdu
      nvtopPackages.full
      lm_sensors
      lshw
      pciutils
      usbutils
      file
      fzf
      gnupg
      gnused
      libsecret
      jq
      mc
      fastfetch
      nix-output-monitor
      ripgrep
      tldr
      which
    ];
  };
}

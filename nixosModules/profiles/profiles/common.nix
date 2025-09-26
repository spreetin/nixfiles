{
  options,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.spreetin;
in
{
  environment.systemPackages = with pkgs; [
    age
    bash
    bc
    cpufrequtils
    dnsmasq
    dosfstools
    findutils
    gparted
    gptfdisk
    killall
    nfs-utils
    ntfs3g
    nix-output-monitor
    openssl
    rsync
    screen
    tree
    xdg-user-dirs
    xdg-utils
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [
      "zfs"
      "btrfs"
    ];
    zfs.forceImportRoot = false;
    tmp.useTmpfs = true;
  };
  catppuccin.grub.enable = lib.mkIf cfg.themes.catppuccin true;
  console.keyMap = "sv-latin1";
  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      font-awesome
      fira
      roboto
      liberation_ttf
      nerd-fonts.liberation
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      openttd-ttf
    ];
    fontDir.enable = true;
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };
  networking = {
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 5353 ];
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 524288000;
      sandbox = true;
      substituters = lib.optional (lib.elem "hyprland" cfg.windowManagers) "https://hyprland.cachix.org";
      trusted-public-keys = lib.optional (lib.elem "hyprland" cfg.windowManagers) "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };
  security = {
    rtkit.enable = true;
  };
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "david" ];
      };
    };
    gvfs.enable = true;
    tumbler.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    fstrim.enable = true;
    hardware.openrgb.enable = true;
  };
  system = {
    stateVersion = "25.05";
  };
  time.timeZone = "Europe/Stockholm";
  programs = {
    mtr.enable = true;
    git.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nh = {
      enable = true;
      flake = "/home/david/dotfiles/";
      clean = {
        enable = true;
        extraArgs = "--keep 10 --keep-since 14d";
      };
    };
  };
}

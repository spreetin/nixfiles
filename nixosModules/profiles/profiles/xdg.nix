{ ... }:

{
  environment = {
    sessionVariables = rec {
      NIXOS_OZONE_WL = "1";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local.share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_MUSIC_DIR = "$HOME/Music";
      XDG_DESKTOP_DIR = "$HOME/Desktop";
      XDG_DOCUMENTS_DIR = "$HOME/Documents";
      XDG_DOWNLOAD_DIR = "$HOME/Downloads";
      XDG_PICTURES_DIR = "$HOME/Pictures";
      XDG_VIDEOS_DIR = "$HOME/Videos";
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };
}

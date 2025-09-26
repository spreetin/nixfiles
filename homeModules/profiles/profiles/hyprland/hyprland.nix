{
  config,
  lib,
  ...
}:
let
  xdg = config.xdg;
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    wayland.windowManager.hyprland.settings = {
      # Default apps
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi";
      "$browser" = "librewolf";
      "$search_engine" = "https://duckduckgo.com/?t=ffab&q={}";

      # Other variables
      "$wall_dir" = "$HOME/Bilder/Wallpapers";
      "$lock" = "pidof hyprlock || hyprlock -q"; # "${xdg.configHome}/hypr/scripts/LockScreen.sh";
      "$scriptsDir" = "${xdg.configHome}/scripts/hypr";

      # Autostart
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpaper"
        "${xdg.configHome}/scripts/waybar/launch.sh"
        "swww-deamon --format xrgb"
        "${xdg.configHome}/scripts/hypr/Polkit.sh"
        "nm-applet --indicator"
        "swaync"
        "bluemon-applet"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "wl-paste --type text --watch xclip -selection clipboard"
      ];

      # Environment variables
      env = [
        # General
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "KITTY_ENABLE_WAYLAND,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "CURRENT_WALLPAPER,${xdg.configHome}/hypr/wallpaper/wallpaper.jpg"
        # Toolkits
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "CLUTTER_BACKEND,wayland"
        # Qt
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_QUICK_CONTROLS_STYLE,org.hyprland.style"
        # Firefox
        "MOZ_ENABLE_WAYLAND,1"
        # Electron
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      # Monitor
      #monitor = ",preferred,auto,auto";

      # Input settings
      input = {
        kb_layout = "se,us";
        kb_options = "grp:alt_shift:toggle";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 30;
        repeat_delay = 300;
        numlock_by_default = true;
        float_switch_override_focus = false;
        touchpad = {
          natural_scroll = false;
        };
      };
      #gestures = {
      #  workspace_swipe = false;
      #};

      # Keybindingss
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, D, exec, pkill $menu || true && $menu -show drun -modi drun,filebrowser,run,window"
        "$mainMod, W, exec, librewolf"
        "$mainMod, A, exec, pkill $menu || true && ags toggle 'overview'"
        #"$mainMod, F, overview:toggle,"
        "$mainMod, Return, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, exec, cliphist list | $menu -dmenu | cliphist decode | wl-copy"
        "$mainMod, R, exec, $menu --show drun"
        "$mainMod, P, pseudo,"
        "CTRL ALT, J, togglesplit"
        "$mainMod, O, exec, ${xdg.configHome}/scripts/waybar/launch.sh"
        "$mainMod, M, exec, killall .waybar-wrapped || waybar"
        "$mainMod SHIFT, Q, exec, $scriptsDir/KillActiveProcess.sh"
        "CTRL ALT, S, exec, $scriptsDir/Keylayout.sh"
        "CTRL ALT, L, exec, $lock" # $scriptsDir/LockScreen.sh"
        "CTRL ALT, P, exec, wlogout"
        "$mainMod SHIFT, N, exec, swaync-client -t -sw"
        "$mainMOD ALT, R, exec, $scriptsDir/Refresh.sh"
        #"$mainMod, S, exec, $scriptsDir/RofiSearch.sh"
        "$mainMod SHIFT, G, exec, $scriptsDir/GameMode.sh"
        "$mainMod ALT, V, exec, $scriptsDir/ClipManager.sh"
        "$mainMod SHIFT, F, fullscreen"
        "$mainMod CTRL, F, fullscreen, 1"
        "$mainMod, SPACE, togglefloating,"
        "$mainMod ALT, SPACE, exec, hyprctl dispatch workspaceopt allfloat"
        "$mainMod SHIFT, Return, exec, [float; move 15% 5%; size 70% 60%] $term"
        "$mainMod CTRL ALT, B, exec, pkill -SIGUSR1 waybar"
        # Focus switch
        "$mainMod, left, movefocus, l"
        "$mainMod, H, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, L, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, K, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, J, movefocus, d"
        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, period, workspace, e+1"
        "$mainMod, comma, workspace, e-1"
        "$mainMod, tab, workspace, m+1"
        "$mainMod SHIFT, tab, workspace, m-1"
        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        # Screenshots
        "$mainMod, Print, exec, $scriptsDir/ScreenShot.sh --now"
        "$mainMod SHIFT, Print, exec, $scriptsDir/ScreenShot.sh --area"
        "$mainMod CTRL, Print, exec, $scriptsDir/ScreenShot.sh --in5"
        "$mainMod CTRL SHIFT, Print, exec, $scriptsDir/ScreenShot.sh --in10"
        "ALT, Print, exec, $scriptsDir/ScreenShot.sh --active"
        # Alt-tab
        "ALT, tab, cyclenext"
        "ALT, tab, bringactivetotop"
        # Move window
        "$mainMod CTRL, left, movewindow, l"
        "$mainMod CTRL, right, movewindow, r"
        "$mainMod CTRL, up, movewindow, u"
        "$mainMod CTRL, down, movewindow, d"
        # Swap windows
        "$mainMod ALT, left, swapwindow, l"
        "$mainMod ALT, right, swapwindow, r"
        "$mainMod ALT, up, swapwindow, u"
        "$mainMod ALT, down, swapwindow, d"
        # Brightness control
        ", code:232, exec, $scriptsDir/Brightness.sh dec"
        ", code:233, exec, $scriptsDir/Brightness.sh inc"
      ];
      bindm = [
        # Move/resize
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
        ", xf86audioraisevolume, exec, $scriptsDir/Volume.sh --inc"
        ", xf86audiolowervolume, exec, $scriptsDir/Volume.sh --dec"
      ];
      bindl = [
        ", xf86AudioMicMute, exec, $scriptsDir/Volume.sh --toggle-mic"
        ", xf86audiomute, exec, $scriptsDir/Volume.sh --toggle"
        ", xf86Sleep, exec, systemctl suspend"
        ", xf86AudioPlayPause, exec, playerctl play-pause"
        ", xf86AudioPause, exec, playerctl pause"
        ", xf86AudioPlay, exec, playerctl play"
        ", xf86AudioNext, exec, playerctl next"
        ", xf86AudioPrev, exec, playerctl previous"
        ", xf86audiostop, exec, playerctl stop"
      ];
      binde = [
        # Resize
        "$mainMod SHIFT, left, resizeactive,-50 0"
        "$mainMod SHIFT, right, resizeactive,50 0"
        "$mainMod SHIFT, up, resizeactive,0 -50"
        "$mainMod SHIFT, down, resizeactive,0 -50"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        # Tags
        "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]firefox-esr|[Ff]irefox-bin)$"
        "tag +browser, class:^[Ll]ibrewolf$"
        "tag +notification, class:^(swaync-control-center|swaync-notification-window|swaync-client|class)$"
        "tag +terminal, class:^(Alacritty|kitty|kitty-dropterm)$"
        "tag +projects, class:^(jetbrains-.+|org.qt-project.qtcreator)$"
        "tag +games, class:^(gamescope|steam_app_\d+)$"
        "tag +gamestore, class:^([Ss]team|[Ll]utris|com.heroicgameslauncher.hgl)$"
        "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt|org.kde.dolphin)$"
        "tag +video, class:^([Mm]pv|vlc)$"
        "tag +settings, title:^(ROG Control)$"
        "tag +settings, class:^(wihotspot(-gui)?)$"
        "tag +settings, class:^([Bb]aobab|org.gnome.[Bb]aobab)$"
        "tag +settings, class:^(gnome-disks|wihotspot(-gui)?)$"
        "tag +settings, class:(Kvantum Manager)"
        "tag +settings, class:^(file-roller|org.gnome.FileRoller)$"
        "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +settings, class:^(qt5ct|qt6ct|[Yy]ad)$"
        "tag +settings, class:(xdg-desktop-portal-gtk)"
        "tag +settings, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "tag +settings, class:^([Rr]ofi)$"
        "tag -settings, class:^(path of building.exe)$"
        # Video
        "noblur, tag:video"
        "opacity 1.0, tag:video"
        # Positions
        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        # Floating
        "float, tag:settings*"
        "float, class:(org.gnome.Calculator), title:(Calculator)"
        "float, class:^([Qq]alculate-gtk)$"
        "float, title:^(Authentication Required)$"
        "center, title:^(Authentication Required)$"
        "float, title:^(Save As)$"
        "size 70% 60%, title:^(Save As)$"
        "center, title:^(Save As)$"
        "float, initialTitle:(Open Files)"
        "size 70% 60%, initialTitle:(Open Files)"
        "center, initialTitle:(Open Files)"
        # Opacity
        #"opacity 1.0 0.95, tag:browser*"
        #"opacity 0.9 0.8, tag:projects*"
        #"opacity 1.0 0.95, tag:file-manager*"
        #"opacity 1.0 0.95, tag:terminal*"
        #"opacity 1.0 0.95, tag:settings*"
        # Size
        "size 70% 70%, tag:settings*"
        # Gaming
        "noblur, tag:games*"
        "fullscreen, tag:games*"
        # Other
        "idleinhibit fullscreen, fullscreen:1"
      ];
      layerrule = [
        # Layers
        "blur, $menu"
        "ignorezero, $menu"
        "blur, notifications"
        "ignorezero, notifications"
      ];

      # Themeing
      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(ddddddff)";
        "col.inactive_border" = "rgba(777777ff)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 4;
        active_opacity = "1.0";
        inactive_opacity = "0.9";
        fullscreen_opacity = "1.0";
        dim_inactive = true;
        dim_strength = "0.1";
        dim_special = "0.8";
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgb(7D4AB4)";
          color_inactive = "rgb(2D1D5F)";
        };
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          ignore_opacity = true;
          new_optimizations = true;
          special = true;
          popups = true;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "linear, 1, 1, 1, 1"
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "smoothIn, 0.5, -0.5, 0.68, 1.5"
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1.0"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 5, winIn, slide"
          "windowsOut, 1, 3, smoothOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, linear"
          "fade, 1, 3, smoothOut"
          "workspaces, 1, 5, winIn, slide"
          "workspacesIn, 1, 5, winIn, slide"
          "workspacesOut, 1, 5, winOut, slide"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      misc = {
        force_default_wallpaper = "-1";
        disable_hyprland_logo = true;
        middle_click_paste = true;
      };
      group = {
        "col.border_active" = "rgb(F3ECF5)";
        groupbar = {
          "col.active" = "rgb(313131)";
        };
      };
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
        pass_mouse_when_bound = false;
      };
      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };
    };
  };
}

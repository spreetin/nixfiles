{
  hostname,
  config,
  lib,
  ...
}:
let
  xdg = config.xdg;
  power-mods = (import ./waybar/power.nix { xdg = config.xdg; });
  pulse-mods = (import ./waybar/pulseaudio.nix { xdg = config.xdg; });
  workspace-mods = (import ./waybar/workspaces.nix);
  temp-mods = (
    if builtins.pathExists ./waybar/temperature.${hostname}.nix then
      (import ./waybar/temperature.${hostname}.nix { xdg = config.xdg; })
    else
      {
        "temperature" = {
          "format" = "";
        };
        "temperature#gpu" = {
          "format" = "";
        };
      }
  );
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          "custom/appmenu" = (import ./waybar/appmenu.nix);
          "backlight" = (import ./waybar/backlight.nix);
          #"battery" = (import ./waybar/battery.nix);
          "bluetooth" = (import ./waybar/bluetooth.nix);
          #"custom/cliphist" = (import ./waybar/cliphist.nix);
          "clock" = (import ./waybar/clock.nix);
          "cpu" = (import ./waybar/cpu.nix);
          "disk" = (import ./waybar/disk.nix);
          #"disk#home" = (import ./waybar/disk-home.nix);
          "custom/empty" = {
            "format" = "";
          };
          #"custom/exit" = (import ./waybar/exit.nix {inherit xdg;});
          #"custom/hypridle" = (import ./waybar/hypridle.nix {inherit xdg;});
          "hyprland/window" = (import ./waybar/hyprland-window.nix);
          "keyboard-state" = (import ./waybar/keyboard-state.nix);
          "hyprland/language" = {
            "format" = "{short}";
          };
          "memory" = (import ./waybar/memory.nix { inherit xdg; });
          #"network" = (import ./waybar/network.nix {inherit xdg;});
          "network#speed" = (import ./waybar/network-speed.nix);
          "custom/power" = power-mods."custom/power";
          #"custom/logout" = power-mods."custom/logout";
          #"custom/reboot" = power-mods."custom/reboot";
          #"custom/hibernate" = power-mods."custom/hibernate";
          #"custom/lock" = power-mods."custom/lock";
          #"group/powergroup" = power-mods."group/powergroup";
          #"power-profiles-daemon" = (import ./waybar/power-profiles.nix);
          "pulseaudio" = pulse-mods."pulseaudio";
          #"pulseaudio#1" = pulse-mods."pulseaudio#1";
          "pulseaudio#microphone" = pulse-mods."pulseaudio#microphone";
          "custom/swaync" = (import ./waybar/swaync.nix);
          #"custom/system" = (import ./waybar/system.nix);
          #"wlr/taskbar" = (import ./waybar/taskbar.nix);
          #"custom/tools" = (import ./waybar/tools.nix);
          "tray" = (import ./waybar/tray.nix);
          #"user" = (import ./waybar/user.nix);
          "custom/weather" = (import ./waybar/weather.nix { inherit xdg; });
          #"hyprland/workspaces" = workspace-mods."hyprland/workspaces";
          "hyprland/workspaces#rw" = workspace-mods."hyprland/workspaces#rw";
          "temperature" = temp-mods."temperature";
          #"temperature#gpu" = temp-mods."temperature#gpu";

          layer = "top";
          exclusive = true;
          passthrough = false;
          position = "top";
          spacing = 4;
          fixed-center = true;
          ipc = true;
          #margin = "0 0 0 0";
          margin-top = 0;
          margin-left = 0;
          margin-right = 0;
          margin-bottom = 0;
          modules-left = [
            "custom/appmenu"
            "temperature"
            "cpu"
            "memory"
            "disk"
            "hyprland/window"
          ];
          modules-center = [
            "keyboard-state"
            "custom/empty"
            "hyprland/workspaces#rw"
            "custom/empty"
            "hyprland/language"
          ];
          modules-right = [
            "tray"
            "network#speed"
            "bluetooth"
            "pulseaudio"
            "pulseaudio#microphone"
            "clock"
            "custom/weather"
            "battery"
            "custom/swaync"
            "custom/power"
          ];
        };
      };
      style = # css
        ''
          @define-color white      	#F2F2F2;
          @define-color black      	#000000;
          @define-color text       	#FFFFFF;
          @define-color lightgray  	#686868;
          @define-color darkgray   	#353535;

          @define-color transparent	rgba(11, 11, 11, 0.9);
          @define-color teal-trans	rgba(1, 117, 84, 0.5);
          @define-color cyan			rgba(53, 140, 169, 1);

          @define-color background-module     @color1;
          @define-color background-module2	@color11;
          @define-color border-color          @color12;
          @define-color button-color          @color10;
          @define-color button-hover          @color13;

          @define-color backgroundlight @color12;
          @define-color backgrounddark #FFFFFF;
          @define-color workspacesbackground1 @color12;
          @define-color workspacesbackground2 #FFFFFF;
          @define-color bordercolor @color11;
          @define-color textcolor1 @color12;
          @define-color textcolor2 #FFFFFF;
          @define-color textcolor3 #FFFFFF;
          @define-color iconcolor #FFFFFF;
          @define-color textColor #bbb;
          @define-color borderColor #ddd;
          @define-color workspaceBackground #bbb;

          * {
            font-family: "Fira Sans Semibold", "Font Awesome 6 Free", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
            border: none;
            border-radius: 0px;
          }

          window#waybar {
            background-color: @transparent;/*transparent;*/
            /*border-radius: 6px;
            border-width: 0px;
            border-style: solid;
            border-color: @borderColor;*/ /*#1e1e2e;*/
            margin-top: 3px;
            margin-left: 5px;
            margin-right: 5px;
            padding-top: 2px;
            padding-bottom: 0px;
            padding-right: 4px;
            padding-left: 4px;
          }

          tooltip {
            background: @transparent; /*#1e1e2e;*/
            border-radius: 12px;
            border-width: 1px;
            border-style: solid;
            border-color: @textColor;
            color: #ffffff;
          }

          #taskbar button,
          #workspaces button {
            padding: 0px 3px;
            margin: 3px 2px;
            border-radius: 4px;
            color: @transparent;
            background-color: @workspaceBackground;
            transition: all 0.1s linear;
            opacity: 0.4;
          }

          #taskbar button.active,
          #workspaces button.active {
              color: @darkTextColor;
              background: @workspacesbackground2;
              border-radius: 4px;
              min-width: 30px;
              animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
              opacity: 1.0;
          }

          #taskbar button:hover,
          #workspaces button:hover {
              color: @red;
              background: @workspacesbackground2;
              border-radius: 3px;
              opacity:0.6;
              animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #workspaces button.focused {
              color: #d8dee9;
          }

          #workspaces button.urgent {
              color: #11111b;
              border-radius: 10px;
          }

          /*-----module groups----*/
          .modules-left {
              /*background-color: @moduleBackground;*/
              /*background: linear-gradient(0deg, @moduleBack3 0%, @moduleBack2 15%, @moduleBack1 100%);*/
              border-radius: 0px 0px 20px 0px;
              padding-top: 3px;
              padding-bottom: 3px;
              padding-right: 10px;
          }
          .modules-right {
              /*background-color: transparent;*/
              /*background-color: @moduleBackground;*/
              /*background: linear-gradient(0deg, @moduleBack3 0%, @moduleBack2 15%, @moduleBack1 100%);*/
              border-radius: 0px 0px 0px 20px;
              padding-top: 3px;
              padding-bottom: 3px;
              padding-left: 10px;
          }

          .modules-center {
              /*background-color: @moduleBackground;*/
              /*background: linear-gradient(0deg, @moduleBack3 0%, @moduleBack2 15%, @moduleBack1 100%);*/
              border-radius: 0px 0px 20px 20px;
            padding-top: 3px;
            padding-bottom: 3px;
            padding-left: 10px;
            padding-right: 6px;
          }

          #backlight,
          #backlight-slider,
          #battery,
          #bluetooth,
          #clock,
          #cpu,
          #disk,
          #idle_inhibitor,
          #keyboard-state,
          #memory,
          #mode,
          #mpris,
          #network,
          #power-profiles-daemon,
          #pulseaudio,
          #pulseaudio-slider,
          #taskbar button,
          #taskbar,
          #temperature,
          #tray,
          #window,
          #wireplumber,
          #workspaces,
          #custom-backlight,
          #custom-browser,
          #custom-cava_mviz,
          #custom-cycle_wall,
          #custom-dot_update,
          #custom-file_manager,
          #custom-keybinds,
          #custom-keyboard,
          #custom-light_dark,
          #custom-lock,
          #custom-hint,
          #custom-hypridle,
          #custom-menu,
          #custom-playerctl,
          #custom-power_vertical,
          #custom-quit,
          #custom-reboot,
          #custom-settings,
          #custom-spotify,
          #custom-swaync,
          #custom-tty,
          #custom-updater,
          #custom-weather,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.default, 
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.severe,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.sunnyDay {
              color: @textColor;
            padding-right: 6px;
            padding-left: 6px;
          }

          #disk.warning,
          #disk#home.warning,
          #temperature.warning {
              color: yellow;
          }

          #disk.critical,
          #disk#home.critical,
          #temperature.critical {
              color: red;
          }

          #temperature.critical {
              background-color: #ff0000;
              color: white;
          }

          @keyframes blink {
              to {
                  color: #000000;
              }
          }

          #custom-hint {
            color: @peach;
            padding-right: 6px;
            padding-left: 6px;
          }

          #pulseaudio.muted {
              color: red;
          }

          #temperature.critical {
              background-color: @red;
          }

          #battery.critical:not(.charging) {
            color: #f53c3c;
            animation-name: blink;
            animation-duration: 3.0s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #pulseaudio-slider,
          #pulseaudio {
              color: @textColor;
            /*color: @foreground;*/
          }

          #backlight-slider slider,
          #pulseaudio-slider slider {
            min-width: 0px;
            min-height: 0px;
            opacity: 0;
            background-image: none;
            border: none;
            box-shadow: none;
          }

          #backlight-slider trough,
          #pulseaudio-slider trough {
            min-width: 80px;
            min-height: 5px;
            border-radius: 5px;
          }

          #backlight-slider highlight,
          #pulseaudio-slider highlight {
            min-height: 10px;
            border-radius: 5px;
          }

          #custom-hypridle,
          #custom-lock,
          #idle_inhibitor {
              color: @teal;
          }

          #custom-weather,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.default, 
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.severe,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.sunnyDay {
            color: @lavender;
            padding-right: 6px;
            padding-left: 6px;
          }

          /*-----Indicators----*/
          #custom-hypridle.notactive,
          #idle_inhibitor.activated {
            color: #39FF14;
          }

          #clock {
            color: @textColor;
              border-radius: 15px;
          }

          #custom-updates {
              color: @yellow;
          }

          /*#custom-swaync{
              color: @textColor;
          }*/

              /*#ffd700;}*/

          #custom-appmenu,
          #custom-power
          #custom-logout
          #custom-reboot
          #custom-hibernate
          #custom-lock {
              color: @textColor; /*moduleBackground;*/
              /*background-color: @transparent;*/ /*#2d0808;*/
              /*border-radius: 10px;*/
              /*border-color: @darkTextColor;*/ /*@moduleBackground;*/
              /*border-width: 1px;
              border-style: solid;*/
          }
          #custom-power 
          #custom-logout
          #custom-reboot
          #custom-hibernate
          #custom-lock
          #custom-appmenu {
              padding-left: 12px;
              padding-right: 13px;
              margin-right: 8px;
          }
          #custom-lock:hover,
          #custom-hibernate:hover,
          #custom-reboot:hover,
          #custom-logout:hover,
          #custom-power:hover,
          #custom-appmenu:hover {
              color: @transparent;
              background-color: @borderColor;
              border-color: @transparent;
              border-width: 0px;
              border-style: solid;
              border-radius: 5px;
          }
          #tray,
          #window {
              color: @darkTextColor;
          }

          #group-powergroup {
            padding-left: 5px;
            padding-right: 6px;
            margin-right: 8px;
          }
        '';
    };
  };
}

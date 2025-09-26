{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.spreetin;
in
{
  config = lib.mkIf (lib.elem "hyprland" cfg.home.windowManager) {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          grace = 1;
        };
        background = {
          monitor = "";
          path = "${pkgs.sddm-chili-theme}/share/sddm/themes/chili/assets/background.jpg";
          blur_size = 3;
          blur_passes = 2;
          noise = "0.0117";
        };
        label = [
          {
            # rgb(9A5BDD)
            monitor = "";
            text = "cmd[update:1000] echo \"$(date +\"%H\"):\"";
            color = "rgb(CCCCCC)";
            font_size = 240;
            font_family = "JetBrainsMono Nerd Font ExtraBold";
            position = "-450, -200";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(date +\"%M\")\"";
            color = "rgb(CCCCCC)";
            font_size = 240;
            font_family = "JetBrainsMono Nerd Font ExtraBold";
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:1000] echo \":$(date +\"%S\")\"";
            color = "rgb(CCCCCC)";
            font_size = 240;
            font_family = "JetBrainsMono Nerd Font ExtraBold";
            position = "450, -200";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "  $USER";
            color = "rgb(CCCCCC)";
            font_size = 24;
            font_family = "Victor Mono Bold Oblique";
            position = "0, 280";
            halign = "center";
            valign = "bottom";
          }
          {
            monitor = "";
            text = "$LAYOUT";
            color = "rgb(CCCCCC)";
            font_size = 12;
            font_family = "Victor Mono Bold Oblique";
            position = "0, 80";
            halign = "center";
            valign = "bottom";
          }
          {
            monitor = "";
            text = "cmd[update:60000] echo \"<b> \"$(uptime -p || ${config.xdg.configHome}/scripts/uptime.sh)\" </b>\"";
            color = "rgb(CCCCCC)";
            font_size = 18;
            font_family = "Victor Mono Bold Oblique";
            position = "0, 0";
            halign = "right";
            valign = "bottom";
          }
          {
            monitor = "";
            text = "cmd[update:3600000] [ -f \"$HOME/.cache/.weather_cache\" ] && cat  \"$HOME/.cache/.weather_cache\"";
            color = "rgb(CCCCCC)";
            font_size = 18;
            font_family = "Victor Mono Bold Oblique";
            position = "50, 0";
            halign = "left";
            valign = "bottom";
          }
        ];
        input-field = {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = "0.2";
          dots_spacing = "0.2";
          dots_center = true;
          outer_color = "rgb(CCCCCC)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(CCCCCC)";
          capslock_color = "rgb(255, 255, 255)";
          fade_on_empty = false;
          font_family = "Victor Mono Bold Oblique";
          placeholder_text = "<i><span foreground=\"##ffffff99\">🔒 Type Password</span></i>";
          hide_input = false;
          position = "0, 120";
          halign = "center";
          valign = "bottom";
        };
      };
    };
  };
}

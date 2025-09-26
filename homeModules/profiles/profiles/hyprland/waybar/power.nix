{ xdg }:

{
  "custom/power" = {
    "format" = " ⏻ ";
    "on-click" = "wlogout"; #//"$HOME/.config/hypr/scripts/Wlogout.sh",
    "on-click-right" = "${xdg.configHome}/hypr/scripts/LockScreen.sh"; #//"$HOME/.config/hypr/scripts/ChangeBlur.sh",
    "tooltip" = true;
    "tooltip-format" = "Left: Power menu\nRight: Lock screen";
  };
  "custom/logout" = {
    "format" = " 󰍃 ";
    "on-click" = "sleep 1; hyprctl dispatch exit";
    "tooltip" = true;
    "tooltip-format" = "Log out";
  };
  "custom/reboot" = {
    "format" = "  ";
    "on-click" = "systemctl reboot";
    "tooltip" = true;
    "tooltip-format" = "Reboot";
  };
  "custom/hibernate" = {
    "format" = " 󰤄 ";
    "on-click" = "systemctl hibernate";
    "tooltip" = true;
    "tooltip-format" = "Hibernate";
  };
  "custom/lock" = {
    "format" = "  ";
    "on-click" = "pidof hyprlock || hyprlock -q";
    "tooltip" = true;
    "tooltip-format" = "Lock screen";
  };
  #"group/powergroup" = {
  #  "orientation" = "horizontal";
  #  "drawer" = {
  #    "transition-duration" = 500;
  #    "transition-left-to-right" = false;
  #  };
  #  "modules" = [
  #    "custom/power"
  #    "custom/reboot"
  #    "custom/logout"
  #   "custom/hibernate"
  #    "custom/lock"
  #  ];
  #};
}

{ xdg }:

{
  "format" = "";
  "return-type" = "json";
  "escape" = true;
  "exec-on-event" = true;
  "interval" = 60;
  "exec" = "~/.config/hypr/scripts/hypridle.sh status";
  "on-click" = "~/.config/hypr/scripts/hypridle.sh toggle";
}

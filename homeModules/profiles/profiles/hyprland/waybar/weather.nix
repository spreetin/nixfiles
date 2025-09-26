{ xdg }:

{
  "format" = "{}";
  "format-alt" = "{alt}: {}";
  "format-alt-click" = "click";
  "interval" = 3600;
  "return-type" = "json";
  "exec" = "${xdg.configHome}/hypr/scripts/Weather.py";
  #//"exec": "$HOME/.config/hypr/UserScripts/Weather.sh",
  #//"exec-if": "ping wttr.in -c1",
  "tooltip" = true;
}

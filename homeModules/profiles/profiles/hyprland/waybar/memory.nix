{ xdg }:

{
  "interval" = 10;
  "format" = "{used:0.1f}G 󰾆";
  "format-alt" = "{percentage}% 󰾆";
  "format-alt-click" = "click";
  "tooltip" = true;
  "tooltip-format" = "{used:0.1f}GB/{total:0.1f}G";
  "on-click-right" = "${xdg.configHome}/hypr/scripts/WaybarScripts.sh --btop";
}

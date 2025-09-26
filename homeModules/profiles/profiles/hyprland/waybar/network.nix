{ xdg }:

{
  "format" = "{ifname}";
  "format-wifi" = "{icon}";
  "format-ethernet" = "󰌘";
  "format-disconnected" = "󰌙";
  "tooltip-format" = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
  "format-linked" = "󰈁 {ifname} (No IP)";
  "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
  "tooltip-format-ethernet" = "{ifname} 󰌘";
  "tooltip-format-disconnected" = "󰌙 Disconnected";
  "max-length" = 30;
  "format-icons" = [
    "󰤯"
    "󰤟"
    "󰤢"
    "󰤥"
    "󰤨"
  ];
  "on-click-right" = "${xdg.configHome}/hypr/scripts/WaybarScripts.sh --nmtui";
}

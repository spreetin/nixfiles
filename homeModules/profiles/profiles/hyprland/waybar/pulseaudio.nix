{ xdg }:

{
  "pulseaudio" = {
    "format" = "{icon} {volume}%";
    "format-bluetooth" = "{icon} 󰂰 {volume}%";
    "format-muted" = "󰖁";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
        "󰕾"
        ""
      ];
      "ignored-sinks" = [
        "Easy Effects Sink"
      ];
    };
    "scroll-step" = "5.0";
    "on-click" = "${xdg.configHome}/hypr/scripts/Volume.sh --toggle";
    "on-click-right" = "pavucontrol -t 3";
    "on-scroll-up" = "${xdg.configHome}/hypr/scripts/Volume.sh --inc";
    "on-scroll-down" = "${xdg.configHome}/hypr/scripts/Volume.sh --dec";
    "tooltip-format" = "{icon} {desc} | {volume}%";
    "smooth-scrolling-threshold" = 1;
  };
  "pulseaudio#1" = {
    "format" = "{icon} {volume}%";
    "format-bluetooth" = "{icon} {volume}%";
    "format-bluetooth-muted" = " {icon}";
    "format-muted" = "󰸈";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
        ""
      ];
    };
    "on-click" = "pamixer --toggle-mute";
    "on-click-right" = "pavucontrol -t 3";
    "tooltip" = true;
    "tooltip-format" = "{icon} {desc} | {volume}%";
  };
  "pulseaudio#microphone" = {
    "format" = "{format_source}";
    "format-source" = " {volume}%";
    "format-source-muted" = "";
    "on-click" = "${xdg.configHome}/hypr/scripts/Volume.sh --toggle-mic";
    "on-click-right" = "pavucontrol -t 4";
    "on-scroll-up" = "${xdg.configHome}/hypr/scripts/Volume.sh --mic-inc";
    "on-scroll-down" = "${xdg.configHome}/hypr/scripts/Volume.sh --mic-dec";
    "tooltip-format" = "{source_desc} | {source_volume}%";
    "scroll-step" = 5;
  };
}

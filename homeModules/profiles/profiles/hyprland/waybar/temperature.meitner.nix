{ xdg }:

{
  "temperature" = {
    "interval" = 10;
    "tooltip" = true;
    "hwmon-path" = [
      "/sys/class/hwmon/hwmon6/temp1_input"
    ];
    "critical-threshold" = 82;
    "warning-threshold" = 70;
    "format-critical" = "C: {temperatureC}°C {icon}";
    "format" = "{temperatureC}°C {icon}";
    "format-icons" = [
      "󰈸"
    ];
    "on-click-right" = "${xdg.configHome}/hypr/scripts/WaybarScripts.sh --nvtop";
  };
  "temperature#gpu" = {
    "interval" = 10;
    "tooltip" = true;
    "hwmon-path" = [
      "/sys/class/hwmon/hwmon0/temp1_input"
    ];
    "critical-threshold" = 82;
    "warning-threshold" = 70;
    "format-critical" = "G: {temperatureC}°C {icon}";
    "format" = "G: {temperatureC}°C {icon}";
    "format-icons" = [
      "󰈸"
    ];
    "on-click-right" = "${xdg.configHome}/hypr/scripts/WaybarScripts.sh --nvtop";
  };
}

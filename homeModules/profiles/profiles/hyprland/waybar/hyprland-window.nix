{
  "max-length" = 60;
  "rewrite" = {
    "(.*) - Brave" = "$1";
    "(.*) - Chromium" = "$1";
    "(.*) - Brave Search" =  "$1";
    "(.*) - Outlook" = "$1";
    "(.*) Microsoft Teams" = "$1";
  };
  "separate-outputs" = true;
}

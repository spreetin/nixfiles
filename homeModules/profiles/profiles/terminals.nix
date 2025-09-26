{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.spreetin;
in
{
  config = mkIf (elem "kitty" cfg.home.terminals) {
    home.file = {
      "${config.xdg.configHome}/kitty/open-actions.conf".source = ../../configs/kitty/open-actions.conf;
      "${config.xdg.configHome}/kitty/ssh.conf".source = ../../configs/kitty/ssh.conf;
    };
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "Liberation Mono";
        package = pkgs.liberation_ttf;
      };
      actionAliases = {
        "launch_tab" = "launch --type=tab --cwd=current";
      };
      settings = {
        cursor_trail = 50;
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = 2;
        scrollback_lines = 5000;
        scrollback_fill_enlarged_window = false;
        url_style = "curly";
        open_url_with = "default";
        url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty maito news sftp ssh";
        detect_urls = true;
        show_hyperlink_targets = true;
        focus_follows_mouse = true;
        sync_to_monitor = true;
        visual_bell_duration = "0.2";
        window_alert_on_bell = true;
        bell_on_tab = "🔔 ";
        confirm_os_window_close = "-1";
        editor = "nvim";
        kitty_mod = "ctrl+shift";
      };
      themeFile = "Catppuccin-Mocha";
      keybindings = {
        "cmd+f1" = "launch_tab mc";
        "cmd+f2" = "launch_tab nvim";
        "cmd+f5" = "launch_tab kitten ssh david@servus";
        "cmd+f6" = "launch_tab kitten ssh david@deck";
        "kitty_mod+c" = "copy_to_clipboard";
        "cmd+c" = "copy_to_clipboard";
        "kitty_mod+v" = "paste_from_clipboard";
        "cmd+v" = "paste_from_clipboard";
        "kitty_mod+s" = "paste_from_selection";
        "shift+insert" = "paste_from_selection";
        "kitty_mod+up" = "scroll_line_up";
        "cmd+up" = "scroll_line_up";
        "kitty_mod+down" = "scroll_line_down";
        "cmd+down" = "scroll_line_down";
        "kitty_mod+page_up" = "scroll_page_up";
        "cmd+page_up" = "scroll_page_up";
        "kitty_mod+page_down" = "scroll_page_down";
        "cmd+page_down" = "scroll_page_down";
        "kitty_mod+home" = "scroll_home";
        "cmd+home" = "scroll_home";
        "kitty_mod+end" = "scroll_end";
        "cmd+end" = "scroll_end";
        "kitty_mod+right" = "next_tab";
        "ctrl+tab" = "next_tab";
        "kitty_mod+left" = "previous_tab";
        "ctrl+shift+tab" = "previous_tab";
        "kitty_mod+t" = "new_tab";
        "cmd+t" = "new_tab";
        "kitty_mod+q" = "close_tab";
        "cmw+w" = "close_tab";
      };
      extraConfig = "
      # - Use additional nerd symbols
      # See https://github.com/be5invis/Iosevka/issues/248
      # See https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
      # Seti-UI + Custom
      symbol_map U+E5FA-U+E6AC Symbols Nerd Font Mono
      # Devicons
      symbol_map U+E700-U+E7C5 Symbols Nerd Font Mono
      # Font Awesome
      symbol_map U+F000-U+F2E0 Symbols Nerd Font Mono
      # Font Awesome Extension
      symbol_map U+E200-U+E2A9 Symbols Nerd Font Mono
      # Material Design Icons
      symbol_map U+F0001-U+F1AF0 Symbols Nerd Font Mono
      # Weather
      symbol_map U+E300-U+E3E3 Symbols Nerd Font Mono
      # Octicons
      symbol_map U+F400-U+F532,U+2665,U+26A1 Symbols Nerd Font Mono
      # Powerline Symbols
      symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font Mono
      # Powerline Extra Symbols
      symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4 Symbols Nerd Font Mono
      # IEC Power Symbols
      symbol_map U+23FB-U+23FE,U+2B58 Symbols Nerd Font Mono
      # Font Logos
      symbol_map U+F300-U+F32F Symbols Nerd Font Mono
      # Pomicons
      symbol_map U+E000-U+E00A Symbols Nerd Font Mono
      # Codicons
      symbol_map U+EA60-U+EBEB Symbols Nerd Font Mono
      # Additional sets
      symbol_map U+E276C-U+E2771 Symbols Nerd Font Mono # Heavy Angle Brackets
      symbol_map U+2500-U+259F Symbols Nerd Font Mono # Box Drawing
      # Some symbols not covered by Symbols Nerd Font
      # nonicons contains icons in the range: U+F101-U+F27D
      # U+F167 is HTML logo, but YouTube logo in Symbols Nerd Font
      symbol_map U+F102,U+F116-U+F118,U+F12F,U+F13E,U+F1AF,U+F1BF,U+F1CF,U+F1FF,U+F20F,U+F21F-U+F220,U+F22E-U+F22F,U+F23F,U+F24F,U+F25F nonicons
      # Emojis
      symbol_map U+1F600-U+1F64F Noto Color Emoji

      include theme.conf
    ";

    };
  };
}

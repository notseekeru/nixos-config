{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "GeistMono Nerd Font";
      size = 12;
    };
    settings = {
      font_family = "GeistMono Nerd Font Bold";
      bold_font = "GeistMono Nerd Font Bold";
      font_size = 12;
      adjust_line_height = "0";
      adjust_column_width = "0";
      cursor_shape = "block";
      cursor_blink_interval = "0";
      scrollback_lines = 10000;
      wheel_scroll_multiplier = "5.0";
      touch_scroll_multiplier = "1.0";
      background_opacity = "0.95";
      confirm_os_window_close = 0;
    };
  };
}

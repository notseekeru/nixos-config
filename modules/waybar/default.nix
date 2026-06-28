{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        exclusive = true;
        reload_style_on_change = true;
        position = "top";
        spacing = 0;
        height = 0;
        "margin-top" = 2;
        "margin-left" = 5;
        "margin-right" = 5;
        "margin-bottom" = 0;

        "modules-left" = [ "group/left" ];
        "modules-center" = [ "hyprland/workspaces" ];
        "modules-right" = [ "group/right" ];

        # ─── LEFT: Clock ───
        "group/left" = {
          orientation = "inherit";
          modules = [
            "clock"
          ];
        };

        # ─── CENTER: Workspaces ───
        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          format = "{icon}";
          "format-icons" = {
            default = "";
            empty = "";
            focused = "";
            active = "";
          };
          "persistent-workspaces" = {
            "*" = 3;
          };
        };

        # # ─── RIGHT: System essentials ───
        "group/right" = {
          orientation = "inherit";
          modules = [
            "pulseaudio"
            "bluetooth"
            "network"
            "battery"
          ];
        };

        # ─── MODULE CONFIGS ───

        clock = {
          format = "{:%H:%M}";
          "format-alt" = "{:%d/%m/%Y}";
          "tooltip-format" = "<span>{calendar}</span>";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "on-click-right" = "mode";
            format = {
              month = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
        };

        bluetooth = {
          format = "󰂯";
          "format-connected" = "󰂱";
          "format-disabled" = "󰂲";
          "on-click" = "blueman-manager";
        };

        pulseaudio = {
          format = "{icon}   {volume}%";
          "tooltip-format" = "{icon}   {volume}%";
          "format-muted" = "  Muted";
          "format-icons" = {
            default = [ "" "" "" ];
          };
          "max-volume" = 100;
          "scroll-step" = 2;
          "smooth-scrolling-threshold" = 1;
          "on-click" = "pavucontrol";
          "on-click-right" = "pamixer -t";
        };

        battery = {
          format = "{icon} {capacity}%";
          "format-discharging" = "{icon} {capacity}%";
          "format-charging" = "{icon} {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-icons" = {
            charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            default = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          "format-full" = "󰂅";
          "tooltip-format" = "{capacity}% {timeTo}";
          interval = 5;
          "on-click" = "rofi -show drun";
          "on-click-right" = ''notify-send -u low "$(upower -i $(upower -e | grep BAT) | grep -E 'percentage|time to empty' | tr -s ' ')"'';
          states = {
            warning = 20;
            critical = 10;
          };
        };

        network = {
          "format-icons" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format = "{icon}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰌗";
          "format-disconnected" = "󰤮";
          "tooltip-format-wifi" = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-ethernet" = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-disconnected" = "Disconnected";
          interval = 3;
          spacing = 1;
          "on-click" = "sudo nm-connection-editor";
        };

      };
    };
    style = builtins.readFile ./style.css;
  };
}

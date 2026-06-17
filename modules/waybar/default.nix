{ config, pkgs, lib, ... }:

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

        # ─── LEFT: Just the clock ───
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
          cursor = true;
          format = "{icon}";
          "format-icons" = {
            default = "";
            empty = "";
            focused = "";
            active = "";
          };
          "persistent-workspaces" = {
            "*" = 4;
          };
        };

        # ─── RIGHT: System essentials + tray ───
        "group/right" = {
          orientation = "inherit";
          modules = [
            "network"
            "pulseaudio"
            "memory"
            "cpu"
            "battery"
            "tray"
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
          "on-click" = "rofi -show drun";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
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

        cpu = {
          interval = 10;
          format = " {usage}%";
          "on-click" = "kitty btop";
        };

        memory = {
          interval = 2;
          format = " {used:0.1f}G";
          "on-click" = "kitty btop";
        };

        battery = {
          format = "{icon}";
          "format-discharging" = "{icon}";
          "format-charging" = "{icon}";
          "format-plugged" = "";
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



        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}

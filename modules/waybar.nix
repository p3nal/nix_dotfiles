{ inputs, pkgs, config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 4;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];

        modules-left = [ "custom/nixos-logo" "hyprland/workspaces" "hyprland/submap" "custom/media" ];
        modules-right = [ "pulseaudio" "network" "disk" "backlight" "battery#bat0" "battery#bat1" "tray" ];
        modules-center = [ "idle_inhibitor" "clock" ];


        "custom/nixos-logo" = {
          format = " 󱄅 ";
          tooltip = false;
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-click = "activate";
        };
        "hyprland/submap" = {
          "format" = "<span style=\"italic\">{}</span>";
          "tooltip" = false;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        disk = {
          format = "{free}% 󰋊";
          path = "/";
        };
        "backlight" = {
          "format" = "{percent}% {icon}";
          "on-scroll-up" = "light -A 1";
          "on-scroll-down" = "light -U 1";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        };
        "battery#bat0" = {
          "adapter" = "AC";
          "bat" = "BAT0";
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "battery#bat1" = {
          "bat" = "BAT1";
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = "󰝟 {icon} {format_source}";
          "format-muted" = "󰝟 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
        };
      };
    };
    style = ''

    * {
      border: none;
      font-family: JetBrainsMono, Font Awesome, Roboto, Arial, sans-serif;
      font-size: 13px;
      color: #${config.colorScheme.colors.base07};
      border-radius: 20px;
    }

    window {
      font-weight: bold;
    }
    window#waybar {
      background: rgba(0, 0, 0, 0);
    }
    /*-----module groups----*/
    .modules-right {
      background-color: #${config.colorScheme.colors.base01};
      margin: 4px 10px 0 0;
    }
    .modules-center {
      background-color: #${config.colorScheme.colors.base01};
      margin: 4px 0 0 0;
    }
    .modules-left {
      margin: 4px 0 0 10px;
      background-color: #${config.colorScheme.colors.base01};
      color: #${config.colorScheme.colors.base07};
    }
    /*-----modules indv----*/
      #workspaces button {
        padding: 1px 5px;
        background-color: transparent;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        background-color: #${config.colorScheme.colors.base0A};
      }

      #workspaces button.focused {
        background-color: #${config.colorScheme.colors.base05};
      }

      #clock,
      #backlight,
      #disk,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #idle_inhibitor {
        padding: 0 10px;
      }
      /*-----Indicators----*/
      #idle_inhibitor.activated {
        color: #${config.colorScheme.colors.base0B};
      }
      #pulseaudio.muted {
        color: #${config.colorScheme.colors.base08};
      }
      #battery.charging {
        color: #2dcc36;
      }
      #battery.warning:not(.charging) {
        color: #e6e600;
      }
      #battery.critical:not(.charging) {
        color: #cc3436;
      }
	  '';
  };
}

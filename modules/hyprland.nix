{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # hyprpaper
  home = {
    file = {
      ".config/hypr/hyprpaper.conf".source = ../config/hypr/hyprpaper.conf;
    };

    # make stuff work on wayland
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,preferred,auto,auto";
      env = [
        "WLR_DRM_NO_ATOMIC,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
      ];
      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(${config.colorScheme.colors.base08}ff) rgba(${config.colorScheme.colors.base0D}ff) 45deg";
        "col.inactive_border" = "rgba(${config.colorScheme.colors.base0C}55) rgba(${config.colorScheme.colors.base08}55) 135deg";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = true;
      };
      input = {
        kb_options = "caps:swapescape";
      };
      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = false;
          size = 3;
          passes = 1;
        };

        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      misc = {
        disable_autoreload = true;
        # force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
        focus_on_activate = true;
        vfr = true;
        vrr = 1;
      };
      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        force_split = 2;
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "on";
        workspace_swipe_distance = 200;
      };

      "device:tpps/2-ibm-trackpoint" = {
        sensitivity = 1.0; # -1.0 - 1.0, 0 means no modification.
      };

      "$mainMod" = "ALT";
      bind = [
        "$mainMod SHIFT, return, exec, kitty"
        "$mainMod SHIFT, C, killactive, "
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, E, exec, dolphin"
        "$mainMod, P, exec, rofi -show drun -show-icons"
        "$mainMod, R, pseudo," # dwindle
        "$mainMod SHIFT, J, togglesplit," # dwindle
        ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
        ", xf86monbrightnessup, exec, ${pkgs.light}/bin/light -A 2"
        ", xf86monbrightnessdown, exec, ${pkgs.light}/bin/light -U 2"
        # Move focus with mainMod + arrow keys
        "$mainMod, K, cyclenext, prev"
        "$mainMod, J, cyclenext,"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, F1, workspace, 11"
        "$mainMod, F2, workspace, 12"
        "$mainMod, F3, workspace, 13"
        "$mainMod, F4, workspace, 14"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, F1, movetoworkspace, 11"
        "$mainMod SHIFT, F2, movetoworkspace, 12"
        "$mainMod SHIFT, F3, movetoworkspace, 13"
        "$mainMod SHIFT, F4, movetoworkspace, 14"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # my shit
        "$mainMod, Tab, workspace, previous"
        "$mainMod SHIFT, space, togglefloating, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fakefullscreen, "
        "$mainMod, return, swapnext, "
        "$mainMod, H, splitratio, -0.2"
        "$mainMod, L, splitratio, +0.2"

        ''$mainMod, Print, exec, ${pkgs.grim}/bin/grim -g "`${pkgs.slurp}/bin/slurp -w 0`" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png && wl-paste > ~/Pictures/screenshots/screenshot-$(date +%a-%d-%b-%H-%M-%S).png | dunstify "Screenshot of the region taken" -t 1000''
        ''SHIFT, Print, exec, ${pkgs.grim}/bin/grim -l 8 -g "`${pkgs.slurp}/bin/slurp -w 0`" - | ${pkgs.swappy}/bin/swappy -f - ''

        #gamemode
        "$mainMod, G, exec, gamemode"

        # wallpaper
        "$mainMod, W, exec, chpaper"

        # swaylock
        "$mainMod CTRL, L, exec, swaylock"

        # lock on lid switch closed or open or somth idk it works.
        ", switch:on:Lid Switch, exec, swaylock"

        # poweroff
        "$mainMod CTRL WIN, Delete, exec, poweroff"

        "SUPER, D, exec, hyprctl keyword monitor HDMI-A-2,preferred,auto,auto,mirror,eDP-1"
        "SUPER, E, exec, hyprctl keyword monitor HDMI-A-2,preferred,auto,auto"

        # clipman
        ''SUPER, V, exec, ${pkgs.clipman}/bin/clipman pick -t rofi --tool-args="-theme gruvbox-dark"''

        # rofi-powermenu
        ''$mainMod, Delete, exec, rofi-powermenu''

        # cmus controls
        ''SUPER, Z, exec, cmus-remote --prev''
        ''SUPER, B, exec, cmus-remote --next''
        ''SUPER, C, exec, cmus-remote --pause''
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "chpaper"
        "waybar"
        "[workspace 2 silent] firefox"
        "[workspace 3 silent] telegram-desktop"
        "[workspace 9 silent] keepassxc"
        "wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store --no-persist"
      ];

      windowrulev2 = [
         # telegram media viewer
        "float, title:^(Media viewer)$"
        # open firefox in workspace 2
        "workspace 2 silent, class:(firefox)"
        "workspace 3 silent, class:(org.telegram.desktop)"
      ];

      xwayland.force_zero_scaling = true;
    };
  };
}

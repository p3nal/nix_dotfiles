{ inputs, pkgs, config, ... }:
let wallpaper_path = "$HOME/Pictures/wallpapers";
in
{

  # hyprpaper
  home = {
    file = {
      ".config/hypr/hyprpaper.conf".source = ../config/hypr/hyprpaper.conf;
    };
    packages = with pkgs; [
      (pkgs.writeShellScriptBin "gamemode" ''
        HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
        if [ "$HYPRGAMEMODE" = 1 ] ; then
                hyprctl --batch "\
                    keyword animations:enabled 0;\
                    keyword decoration:drop_shadow 0;\
                    keyword decoration:blur:enabled 0;\
                    keyword general:gaps_in 0;\
                    keyword general:gaps_out 0;\
                    keyword general:border_size 1;\
                    keyword decoration:rounding 0"
                exit
            fi
            hyprctl reload
      '')
      (pkgs.writeShellScriptBin "chpaper" ''
        if [[ "`hyprctl hyprpaper`" == *"Couldn't connect to"* ]]; then
          pkill swaybg
          hyprpaper &
          sleep 1
        fi
        WAL_PATH="${wallpaper_path}"
        WALLPAPER="$(ls $WAL_PATH| sed -n "$((RANDOM%$(ls $WAL_PATH| wc -l)+1))p")"
        hyprctl hyprpaper preload $WAL_PATH/$WALLPAPER
        hyprctl hyprpaper wallpaper "eDP-1,`echo $WAL_PATH/$WALLPAPER`"
        hyprctl hyprpaper unload all
        if [[ "`hyprctl hyprpaper`" == *"Couldn't connect to"* ]]; then
          pkill swaybg
          swaybg -i $WAL_PATH/$WALLPAPER &
        fi
      '')
    ];

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
      env = [
        "WLR_DRM_NO_ATOMIC,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(${config.colorScheme.colors.base0A}ee) rgba(${config.colorScheme.colors.base0D}ee) 45deg";
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

      "device:epic-mouse-v1" = {
        sensitivity = -0.5;
      };

      "$mainMod" = "ALT";
      bind = [
        "$mainMod SHIFT, return, exec, kitty"
        "$mainMod SHIFT, C, killactive, "
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating, "
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

        ''SHIFT, Print, exec, ${pkgs.grim}/bin/grim -l 8 -g "''$(${pkgs.slurp}/bin/slurp)" - |  ${pkgs.wl-clipboard}/bin/wl-copy''
        # ''CTRL, Print, exec, ${pkgs.grim}/bin/grim -l 8 -g "''$(${pkgs.slurp}/bin/slurp)" - |  ${pkgs.wl-clipboard}/bin/wl-copy''
        ''$mainMod, Print, exec, ${pkgs.grim}/bin/grim -l 8 -g "''$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - ''

        #gamemode
        "$mainMod, G, exec, gamemode"

        # wallpaper
        "$mainMod, W, exec, chpaper"

        # swaylock
        "$mainMod CTRL, L, exec, swaylock"

        ", switch:Lid Switch, exec, swaylock"


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
        "[workspace 9 silent] keepassxc"
      ];

      xwayland.force_zero_scaling = true;
    };
  };
}

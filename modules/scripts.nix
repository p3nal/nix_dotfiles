{
  pkgs,
  ...
}:
let
  wallpaper_path = "$HOME/Pictures/wallpapers";
in
{
  home = {
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
  };
}

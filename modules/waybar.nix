{inputs, pkgs, ...}:
{
	programs.waybar = {
		enable = true;
		settings = {
		  mainBar = {
                   layer = "top";
                   position = "top";
                   height = 30;
                   output = [
                     "eDP-1"
                     "HDMI-A-1"
                   ];

		   modules-left = [ "hyprland/workspaces" ];
		   modules-right = [ "network" "disk" "battery" "backlight" "clock" ];
		   modules-center = ["hyprland/window"];

                   "hyprland/workspaces" = {
		     format = "{icon}";
                     on-scroll-up = "hyprctl dispatch workspace e+1";
                     on-scroll-down = "hyprctl dispatch workspace e-1";
		     on-click = "activate";
                   };
                   "custom/hello-from-waybar" = {
                     format = "hello {}";
                     max-length = 40;
                     interval = "once";
                     exec = pkgs.writeShellScript "hello-from-waybar" ''
                       echo "from within waybar"
                     '';
                   };
                 };
		};
	};
}

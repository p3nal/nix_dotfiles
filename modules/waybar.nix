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
				modules-right = ["mpd" "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "keyboard-state" "hyprland/language" "battery" "battery#bat2" "clock" "tray"];
				modules-center = ["hyprland/window"];


				keyboard-state=  {
					numlock = true;
					capslock = true;
					format = "{name} {icon}";
					format-icons= {
						locked= "";
						unlocked= "";
					};
				};
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

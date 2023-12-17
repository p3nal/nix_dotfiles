{inputs, pkgs, config, ...}:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
	      width = 300;
	      height = 300;
	      offset = "30x50";
	      origin = "top-right";
	      transparency = 10;
	      frame_color = "#eceff1";
	      font = "JetBrainsMono";
      };

      urgency_normal = {
	      foreground = "#${config.colorScheme.colors.base04}";
	      background = "#${config.colorScheme.colors.base00}";
	      timeout = 6;
      };
    };
  };
}

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
	      frame_color = "#${config.colorScheme.colors.base0E}";
	      font = "JetBrainsMono";
      };

      urgency_normal = {
	      foreground = "#${config.colorScheme.colors.base04}";
	      background = "#${config.colorScheme.colors.base01}";
	      timeout = 6;
      };
    };
  };
}

{
  inputs,
  pkgs,
  config,
  ...
}: let
  colors = config.colorScheme.colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        # frame_color = "#${colors.base0E}";
        frame_color = "#${colors.base0A}55";
        font = "JetBrainsMono Nerd Font Medium 8";
        corner_radius = 10;
      };

      urgency_normal = {
        foreground = "#${colors.base04}";
        background = "#${colors.base01}";
        timeout = 6;
      };
    };
  };
}

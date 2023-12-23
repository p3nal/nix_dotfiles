{
  pkgs,
  config,
  ...
}: let
  colors = config.colorScheme.colors;
in {
  programs.swaylock = {
    enable = true;
    settings = {
      image = "$HOME/Pictures/wallpapers/wp11058333.png";
      color = "${colors.base02}";
      inside-color = "${colors.base0C}";
      font = "JetBrainsMono Nerd Font Medium";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      key-hl-color = "${colors.base0B}";
      bs-hl-color = "${colors.base08}";
      line-color = "${colors.base06}";
      ring-color = "${colors.base0D}";
      ring-clear-color = "${colors.base0F}";
      inside-clear-color = "${colors.base08}";
      ring-caps-lock-color = "${colors.base09}";
      ring-ver-color = "${colors.base0D}";
      inside-ver-color = "${colors.base0D}";
      text-ver-color = "${colors.base07}";
      text-clear-color = "${colors.base01}";
      ring-wrong-color = "${colors.base08}";
      inside-wrong-color = "${colors.base08}";
      separator-color = "${colors.base03}";
      show-failed-attempts = true;
    };
  };
}

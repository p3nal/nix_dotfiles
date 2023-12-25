{ config
, lib
, pkgs
, ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font Medium 8";
    theme = ../config/rofi/rofi-gruvbox-dark.rasi;
    extraConfig = {
      bw = 1;
      # border = "10px solid";
      border-radius = "10px solid";
      scrollbar = false;
      show-icons = true;
      display-drun = "  ";
      drun-display-format = "{name}";
      icon-theme = "Gruvbox-Dark";
    };
  };
}

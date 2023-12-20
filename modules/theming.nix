# putting this here cuz i dont know where else to put it
# base08 - red
# base09 - orange
# base0A - yellow
# base0B - green
# base0C - aqua/cyan
# base0D - blue
# base0E - purple
# base0F - brown

{ inputs, pkgs, config, ... }:
let gruvboxplus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
  home.file = {
    ".config/gtk-3.0/gtk.css".source = ../config/gtk-3.0/gtk.css;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    cursorTheme.name = "Bibata-Modern-Classic";
    iconTheme = {
      package = gruvboxplus;
      name = "GruvboxPlus";
    };
    font = {
      name = "JetBrainsMono Bold";
      size = 10;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  qt = {
    enable = true;
    platformTheme = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}

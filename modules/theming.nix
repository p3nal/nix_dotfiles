{ inputs, pkgs, config, ... }:
let gruvboxplus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
  home.file = {
    ".config/gtk-3.0/gtk.css".source = ../config/gtk-3.0/gtk.css;
  };

  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Classic";
    iconTheme.package = gruvboxplus;
    iconTheme.name = "GruvboxPlus";
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

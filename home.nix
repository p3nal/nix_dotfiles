{ config, pkgs, inputs, ... }:

let gruvboxplus = import ./modules/gruvbox-plus.nix {inherit pkgs; };
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./modules/hyprland.nix
    # ./modules/waybar.nix
    ./modules/kitty.nix
    ./modules/dunst.nix
    ./modules/firefox.nix
    ./modules/neovim.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "penal";
  home.homeDirectory = "/home/penal";

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.dconf
    pkgs.zathura
    pkgs.sxiv
    pkgs.neofetch
    pkgs.waybar
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/rofi/config.rasi".text = ''
      @theme "${pkgs.rofi-wayland}/share/rofi/themes/gruvbox-dark.rasi"
      * {
        font: "JetBrainsMono Bold 10";
      }
   '';
   ".config/waybar/config".source = ./waybar/config;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/penal/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "neovim";
  };


  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    ssh.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
	lah = "ls -laht";
	".." = "cd ..";
      };
      enableCompletion = true;
      profileExtra = ''export XDG_DATA_DIRS="''$HOME/.nix-profile/share:''${XDG_DATA_DIRS}"'';
    };
    git = {
      enable = true;
      userName = "p3nal";
      userEmail = "abdullah.og@protonmail.com";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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
	size = 8;
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
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "image/*" = [ "sxiv.desktop" ];
      "video/png" = [ "vlc.desktop" ];
      "video/jpg" = [ "vlc.desktop" ];
      "video/*" = [ "vlc.desktop" ];
    };
  };
}

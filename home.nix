{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./modules/xdg.nix
    ./modules/git.nix
    ./modules/neofetch.nix
    ./modules/rofi.nix
    ./modules/scripts.nix
    ./modules/swaylock.nix
    ./modules/theming.nix
    ./modules/bash.nix
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/kitty.nix
    ./modules/dunst.nix
    ./modules/firefox.nix
    ./modules/neovim.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "penal";
  home.homeDirectory = "/home/penal";

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;

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
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    dconf
    sxiv
    neofetch
    waybar
    hyprpaper
    hyprpicker
    swaybg
    wl-clipboard
    grim
    slurp
    wl-screenrec
    tree
    gdu
    brave
    telegram-desktop
    qbittorrent
    alejandra
    cmus
    inputs.lga.packages.${pkgs.system}.default
    libreoffice
    freetube
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # shhh quiet.
    ".hushlogin".text = "";
    # cmus colo
    ".config/cmus/rc".text = "colorscheme gruvbox-warm";
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
    EDITOR = "nvim";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    ssh.enable = true;
    direnv.enable = true;
    zathura = {
      enable = true;
      extraConfig = ''
        set statusbar-page-percent true
        set default-bg #${config.colorScheme.colors.base07}
        set default-bg #${config.colorScheme.colors.base00}
        set selection-clipboard clipboard
      '';
    };
  };

  # https://nixos.wiki/wiki/Virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}

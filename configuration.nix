{ config
, lib
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.iwd.enable = true;
  networking.firewall.enable = true;
  systemd.network.enable = true;
  networking.useNetworkd = true;
  systemd.network.wait-online.enable = false;
  systemd.services.systemd-udev-settle.enable = false;
  networking.nameservers = [
    "45.90.28.0#7b342b.dns.nextdns.io"
    "2a07:a8c0::#7b342b.dns.nextdns.io"
    "45.90.30.0#7b342b.dns.nextdns.io"
    "2a07:a8c1::#7b342b.dns.nextdns.io"
  ];
  services.resolved = {
    enable = true;
    llmnr = "false";
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
  services.tlp = {
    enable = true;
    # settings = {
    #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    #   CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #   CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

    #   CPU_MIN_PERF_ON_AC = 0;
    #   CPU_MAX_PERF_ON_AC = 100;
    #   CPU_MIN_PERF_ON_BAT = 0;
    #   CPU_MAX_PERF_ON_BAT = 80;
    # };
  };
  # add other kernel params
  boot = {
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      # 25% more perf at the cost of accepting some residual risk, ill take it
      "mitigations=off"
      "nowatchdog"
      "modprobe.blacklist=iTCO_wdt"
      # for screenrec, basically
      "i915.enable_guc=2"
      "intel_iommu=on"
    ];
    tmp = {
      useTmpfs = lib.mkDefault true;
      cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
      tmpfsSize = "40%";
    };
    kernel.sysctl = {
      # disable sysrq
      "kernel.sysrq" = 0;
      # disable coredumps
      "kernel.core_pattern" = "/dev/null";
      # TCP hardening
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_syncookies" = 1;
    };
    kernelModules = [
      "tcp_bbr"
    ];
  };

  services.getty.greetingLine = "Cash Rules Everything Around Me";

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs = {
    light.enable = true;
    hyprland.enable = true;
    nano.enable = false; # remove nixos bloat
    virt-manager.enable = true;
  };

  security.pam.services.swaylock = { };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # docker
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = lib.mkDefault false;
    };
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.penal = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" "video" "input" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      dunst
      libnotify
      firefox
      keepassxc
      syncthing
      vlc
      alsa-utils
      inkscape
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    mesa
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    unzip
    sops
    home-manager
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      liberation_ttf
      fira-code
      fira-code-symbols
      ubuntu_font_family
      font-awesome
    ];
  };


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    # syncthing
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    # syncthing
    22000
    21027
  ];

  # sops-nix
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  # sops.age.sshKeyPaths = [ "/home/penal/.ssh/id_ed25519" ];
  sops.age.keyFile = "/home/penal/.config/sops/age/keys.txt";


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

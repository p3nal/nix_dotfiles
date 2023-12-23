{
  inputs,
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark Hard";
    font.name = "JetBrainsMono Nerd Font Medium";
    font.size = 10;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      foreground = "#${config.colorScheme.colors.base05}";
      background = "#${config.colorScheme.colors.base00}";
    };
    shellIntegration.enableBashIntegration = true;
  };
}

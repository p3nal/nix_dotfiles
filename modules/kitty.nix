{inputs, pkgs, config, ...}:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      foreground = "#${config.colorScheme.colors.base05}";
      background = "#${config.colorScheme.colors.base00}";
    };
  };
}

{
  pkgs,
  ...
}:
{
  home.file = {
    ".config/neofetch/config.conf".source = ../config/neofetch/config.conf;
  };
}

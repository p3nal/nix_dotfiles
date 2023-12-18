{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
    ];

    extraLuaConfig = ''
	    ${builtins.readFile ../config/nvim/options.lua}
    '';
  };
}

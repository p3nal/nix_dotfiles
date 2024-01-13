{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rust-analyzer
      luajitPackages.lua-lsp
      python311Packages.python-lsp-server
      marksman
      ripgrep
      rnix-lsp
      fd

      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      vim-rhubarb
      vim-sleuth
      vim-floaterm
      which-key-nvim
      gitsigns-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      nvim-lspconfig
      comment-nvim
      gruvbox-nvim
      neodev-nvim
      lualine-nvim
      nvim-web-devicons
      indent-blankline-nvim
      undotree
      nvim-tree-lua
      vim-nix

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-json
        p.tree-sitter-rust
        p.tree-sitter-cpp
        p.tree-sitter-c
        p.tree-sitter-go
      ]))
    ];

    extraLuaConfig = ''
      ${builtins.readFile ../config/nvim/options.lua}
      ${builtins.readFile ../config/nvim/keybindings.lua}
      ${builtins.readFile ../config/nvim/plugins/cmp.lua}
      ${builtins.readFile ../config/nvim/plugins/lsp.lua}
      ${builtins.readFile ../config/nvim/plugins/misc.lua}
      ${builtins.readFile ../config/nvim/plugins/lualine.lua}
      ${builtins.readFile ../config/nvim/plugins/telescope.lua}
      ${builtins.readFile ../config/nvim/plugins/treesitter.lua}
    '';
  };
}

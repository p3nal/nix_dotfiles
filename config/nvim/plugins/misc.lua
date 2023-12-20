-- colo
vim.cmd("colorscheme gruvbox")

-- comment
require("Comment").setup()

-- identation on blank lines
require("ibl").setup()

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-tree

require("nvim-tree").setup({
  disable_netrw = false,
  hijack_netrw = true,
})


-- colo
vim.cmd("colorscheme gruvbox")

-- comment
require("Comment").setup()

-- identation on blank lines
-- require("indent-blankline").setup({
--       char = '┊',
--       show_trailing_blankline_indent = false,
-- })

-- Setup neovim lua configuration
require('neodev').setup()


-- ~/.config/nvim/plugin/gitsigns.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    name = "gitsigns",
  },
})
-- }}}

-- Configure {{{
do
  -- Colors to match Snacks Explorer
  vim.api.nvim_set_hl(0, "GitGutterAdd", { fg = vim.g.terminal_color_2 })
  vim.api.nvim_set_hl(0, "GitGutterChange", { fg = vim.g.terminal_color_5 })
  vim.api.nvim_set_hl(0, "GitGutterChangeDelete", { fg = vim.g.terminal_color_5 })
  vim.api.nvim_set_hl(0, "GitGutterDelete", { fg = vim.g.terminal_color_1 })
end
-- }}}

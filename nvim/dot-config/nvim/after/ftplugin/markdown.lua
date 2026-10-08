-- ~/.config/nvim/after/ftplugin/markdown.lua | Curtis Free (https://curtisfree.com)
-- Neovim settings specific to Markdown files (includes VimWiki!).

-- Keep lines <= 100 chars
vim.opt_local.textwidth = 100
vim.opt_local.colorcolumn = "101"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = vim.g.terminal_color_8 })

-- Colors & Highlighting

vim.treesitter.start()

-- ▶︎ ROY G BV... (or as close as I could get!)
--   ▶︎ Based on the "terminal colors" as set by base16-tomorrow{,-night}
vim.api.nvim_set_hl(0, "Header1", { fg = vim.g.terminal_color_1, bold = true })
vim.api.nvim_set_hl(0, "Header2", { fg = vim.g.terminal_color_3, bold = true })
vim.api.nvim_set_hl(0, "Header3", { fg = vim.g.terminal_color_2, bold = true })
vim.api.nvim_set_hl(0, "Header4", { fg = vim.g.terminal_color_6, bold = true })
vim.api.nvim_set_hl(0, "Header5", { fg = vim.g.terminal_color_4, bold = true })
vim.api.nvim_set_hl(0, "Header6", { fg = vim.g.terminal_color_5, bold = true })

-- ▶︎ Apply to markdown headers in Treesitter
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "Header1" })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "Header2" })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "Header3" })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "Header4" })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { link = "Header5" })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { link = "Header6" })

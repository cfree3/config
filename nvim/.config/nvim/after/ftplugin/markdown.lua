-- ~/.config/nvim/after/ftplugin/markdown.lua | Curtis Free (https://curtisfree.com)
-- Neovim settings specific to Markdown files (includes VimWiki!).

-- Keep lines <= 100 chars
vim.opt_local.textwidth = 100
vim.opt_local.colorcolumn = "101"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkYellow", bold = true })

-- Colors & Highlighting

vim.treesitter.start()

-- ▶︎ ROY G BV (or as close as I could get!)
vim.api.nvim_set_hl(0, "Header1", { fg = "Red", bold = true })
vim.api.nvim_set_hl(0, "Header2", { fg = "DarkYellow", bold = true })
vim.api.nvim_set_hl(0, "Header3", { fg = "Yellow", bold = true })
vim.api.nvim_set_hl(0, "Header4", { fg = "Green", bold = true })
vim.api.nvim_set_hl(0, "Header5", { fg = "Blue", bold = true })
vim.api.nvim_set_hl(0, "Header6", { fg = "DarkMagenta", bold = true })

-- ▶︎ Apply to markdown headers in Treesitter
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "Header1" })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "Header2" })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "Header3" })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "Header4" })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { link = "Header5" })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { link = "Header6" })

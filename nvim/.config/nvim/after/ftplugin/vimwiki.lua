-- ~/.config/nvim/after/ftplugin/vimwiki.lua | Curtis Free (https://curtisfree.com)
-- Neovim settings specific to VimWiki files.

-- Easy movement between days (overrides usual buffer keymaps)
vim.keymap.set("n", "<C-h>", ":VimwikiDiaryPrevDay<CR>", { buffer = true })
vim.keymap.set("i", "<C-h>", "<C-o>:VimwikiDiaryPrevDay<CR>", { buffer = true })
vim.keymap.set("n", "<C-l>", ":VimwikiDiaryNextDay<CR>", { buffer = true })
vim.keymap.set("i", "<C-l>", "<C-o>:VimwikiDiaryNextDay<CR>", { buffer = true })

-- (Not on a diary entry? Prev goes to latest entry, and Next does nothing)

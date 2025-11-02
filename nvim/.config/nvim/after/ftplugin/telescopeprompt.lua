-- ~/.config/nvim/after/ftplugin/telescopeprompt.lua | Curtis Free (https://curtisfree.com)
-- Neovim settings specific to the Telescope floating window.

-- Colors & Style

vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Directory" })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "ModeMsg" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "ModeMsg" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "ModeMsg" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "ModeMsg" })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { link = "Normal" })

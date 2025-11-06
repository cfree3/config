-- ~/.config/nvim/lua/plugins/lazy.lua | Curtis Free (https://curtisfree.com)

-- Bootstrap {{{
-- (per https://lazy.folke.io/installation)
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazy_path)
-- }}}

-- Configuration {{{
require("lazy").setup({
  checker = {
    enabled = true,
  },
  change_detection = {
    enabled = false,
  },
  rocks = {
    enabled = false,
  },
  lockfile = vim.fn.stdpath("state") .. "/lazy/lock.json",
  git = {
    -- wait 4 hours before checking again for updates to a plugin
    -- (to avoid fetching every time I start Neovim)
    cooldown = 14400,
  },
  spec = {
    {
      import = "plugins.spec",
    },
  },
  ui = {
    backdrop = 100,
    border = "rounded",
    pills = false,
    size = {
      width = 0.40,
      height = 0.50,
    },
    title = " Plugins ",
    title_pos = "center",
  },
})
-- }}}

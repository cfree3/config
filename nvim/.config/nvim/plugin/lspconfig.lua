-- ~/.config/nvim/plugin/lspconfig.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/neovim/nvim-lspconfig",
    name = "lspconfig",
  },
})
-- }}}

-- Configure {{{
do
  -- Track which LSPs to use
  local lsps = {
    go = {
      name = "gopls",
      exe = "gopls",
      pattern = "*.go",
    },
    lua = {
      name = "lua_ls",
      exe = "lua-language-server",
      pattern = "*.lua",
    },
    python = {
      name = "pylsp",
      exe = "pylsp",
      pattern = "*.py",
    },
  }

  -- Enable those LSPs iff they are installed
  for _, lang in pairs(lsps) do
    if vim.fn.executable(lang.exe) == 1 then
      vim.lsp.enable(lang.name)
      -- Show the sign column in files of this type
      -- (easier to read than signcolumn = "number")
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = lang.pattern,
        callback = function()
          vim.opt_local.signcolumn = "yes"
        end,
      })
    end
  end
end
-- }}}

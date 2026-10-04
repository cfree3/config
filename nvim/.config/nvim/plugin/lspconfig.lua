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
    end
  end
end
-- }}}

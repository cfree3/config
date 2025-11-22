-- ~/.config/nvim/lua/plugins/spec/lspconfig.lua | Curtis Free (https://curtisfree.com)

return {
  "neovim/nvim-lspconfig",
  name = "lspconfig",
  init = function()
    -- Track which LSPs to use (language = "executable")
    local lsps = {
      go = "gopls",
      lua = "lua_ls",
    }
    -- Enable those LSPs iff they are installed
    for _, exe in pairs(lsps) do
      if vim.fn.executable(exe) then
        vim.lsp.enable(exe)
      end
    end
  end,
}

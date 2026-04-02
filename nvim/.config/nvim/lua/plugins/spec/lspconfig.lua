-- ~/.config/nvim/lua/plugins/spec/lspconfig.lua | Curtis Free (https://curtisfree.com)

return {
  "neovim/nvim-lspconfig",
  name = "lspconfig",
  init = function()
    -- Track which LSPs to use
    local lsps = {
      go = {
        exe = "gopls",
        pattern = "*.go",
      },
      lua = {
        exe = "lua_ls",
        pattern = "*.lua",
      },
    }
    -- Enable those LSPs iff they are installed
    for _, lang in pairs(lsps) do
      if vim.fn.executable(lang.exe) then
        vim.lsp.enable(lang.exe)
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
    -- Configure how Neovim should surface diagnostics
    vim.diagnostic.config({
      virtual_text = {
        virt_text_pos = "eol",
        virt_text_win_col = 82,
      },
    })
  end,
}

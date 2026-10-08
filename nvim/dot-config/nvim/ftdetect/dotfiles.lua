-- ~/.config/nvim/ftdetect/dotfiles.lua | Curtis Free (https://curtisfree.com)
-- Translate Stow "dot" file convention.

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "dot-*" },
  callback = function(event)
    local dotfilename = vim.fs.basename(event.file):gsub("^dot%-(.*)$", ".%1")
    local dotfiletype = vim.filetype.match({ filename = dotfilename })

    -- default to basic "conf" if we couldn't determine filetype from name
    vim.opt_local.filetype = dotfiletype or "conf"
  end,
})

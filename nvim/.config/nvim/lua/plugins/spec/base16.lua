-- ~/.config/nvim/lua/plugins/spec/base16.lua | Curtis Free (https://curtisfree.com)

return {
  "RRethy/base16-nvim",
  name = "base16",
  lazy = false,
  config = function()
    vim.g.base16colorspace = 256

    -- Set colorscheme based on system mode (dark/light)
    do
      local color_dark = "base16-tomorrow-night"
      local color_light = "base16-tomorrow"

      if vim.fn.has("mac") == 1 then
        -- https://www.reddit.com/r/neovim/comments/y2by27/comment/is24btb/
        -- https://github.com/neovim/neovim/issues/21376
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local mode = vim.fn.trim(handle:read("*a"))
        handle:close()
        if mode == "Dark" then
          vim.cmd.colorscheme(color_dark)
        else
          vim.cmd.colorscheme(color_light)
        end

      -- (Default to preferred dark theme if we aren't on macOS)
      else
        vim.cmd.colorscheme(color_dark)
      end
    end
  end,
}

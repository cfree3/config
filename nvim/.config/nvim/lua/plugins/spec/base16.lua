-- ~/.config/nvim/lua/plugins/spec/base16.lua | Curtis Free (https://curtisfree.com)

return {
  "RRethy/base16-nvim",
  name = "base16",
  lazy = false,
  config = function()
    vim.g.base16colorspace = 256

    -- Set colorscheme based on system mode (dark/light)
    local colorscheme_dark = "base16-tomorrow-night"
    local colorscheme_light = "base16-tomorrow"

    -- Default to dark mode
    local dark_mode = true

    -- Attempt to query macOS color mode (light/dark)
    if vim.fn.has("mac") == 1 then
      -- https://www.reddit.com/r/neovim/comments/y2by27/comment/is24btb/
      -- https://github.com/neovim/neovim/issues/21376
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      if handle == nil then
        error("Unable to read macOS color mode (light/dark)")
      else
        dark_mode = vim.fn.trim(handle:read("*a")) == "Dark"
        handle:close()
      end
    end

    -- And set the theme!
    vim.cmd.colorscheme(dark_mode and colorscheme_dark or colorscheme_light)
  end,
}

-- ~/hammerspoon/init.lua | Curtis Free (https://curtisfree.com)
-- Configuration for the Hammerspoon macOS automation utility.

--
--  I want things to happen at the speed of water, not molasses!
--    (See https://github.com/Hammerspoon/hammerspoon/issues/923.)
--
hs.window.animationDuration = 0

--
--  Pad windows by this many pixels.
--    (Just set to 0 for no extra padding.)
--

window_padding = 5

--
--  Most of this is simple and largely from Hammerspoon's "Getting Started"
--  documentation (http://www.hammerspoon.org/go/).
--

-- Keyboard!
--   | fn | ctrl | alt (opt) | cmd | space | ...

bind_onekey   = {                "cmd" }
bind_twokey   = { "ctrl", "alt"        }
bind_threekey = { "ctrl", "alt", "cmd" }

--
--  Vi(m) keys:
--    h = Left
--    j = Down
--    k = Up
--    l = Right
--

--
--  ( 2 key ) + '
--
--    Interactive window resizing and placement.
--
hs.grid.setGrid({ w=6, h=4 })
hs.grid.setMargins({ w=window_padding, h=window_padding })
hs.grid.ui.textSize = 40
hs.grid.ui.showExtraKeys = false
hs.hotkey.bind(bind_twokey, "'", function()
    hs.grid.show()
end)

--
--  ( 2 key ) + h
--
--    Move window to left half of the screen.
--
hs.hotkey.bind(bind_twokey, "h", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + window_padding
  windowFrame.y = screenFrame.y + window_padding
  windowFrame.w = screenFrame.w / 2 - ( 2 * window_padding )
  windowFrame.h = screenFrame.h - ( 2 * window_padding )

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + j
--
--    Move window to bottom half of the screen.
--
hs.hotkey.bind(bind_twokey, "j", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + window_padding
  windowFrame.y = screenFrame.y + ( screenFrame.h / 2 ) + window_padding
  windowFrame.w = screenFrame.w - ( 2 * window_padding )
  windowFrame.h = screenFrame.h / 2 - ( 2 * window_padding )

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + k
--
--    Move window to upper half of the screen.
--
hs.hotkey.bind(bind_twokey, "k", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + window_padding
  windowFrame.y = screenFrame.y + window_padding
  windowFrame.w = screenFrame.w - ( 2 * window_padding )
  windowFrame.h = screenFrame.h / 2 - ( 2 * window_padding )

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + l
--
--    Move window to right half of the screen.
--
hs.hotkey.bind(bind_twokey, "l", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + ( screenFrame.w / 2 ) + window_padding
  windowFrame.y = screenFrame.y + window_padding
  windowFrame.w = screenFrame.w / 2 - ( 2 * window_padding )
  windowFrame.h = screenFrame.h - ( 2 * window_padding )

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + b
--
--    Move window to left third of the screen.
--
hs.hotkey.bind(bind_twokey, "b", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 3
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + n
--
--    Move window to middle third of the screen.
--
hs.hotkey.bind(bind_twokey, "n", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + ( screenFrame.w / 3 )
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 3
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)

end)

--
--  ( 2 key ) + m
--
--    Move window to right third of the screen.
--
hs.hotkey.bind(bind_twokey, "m", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + 2 * ( screenFrame.w / 3 )
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 3
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)

end)

--
-- ( 2 key ) + ;
--
--   Make window take up the entire screen.
--   (NOT macOS's fullscreen takeover.)
--
hs.hotkey.bind(bind_twokey, ";", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x + window_padding
  windowFrame.y = screenFrame.y + window_padding
  windowFrame.w = screenFrame.w - ( 2 * window_padding )
  windowFrame.h = screenFrame.h - ( 2 * window_padding )

  window:setFrame(windowFrame)

end)

--
-- ( 3 key ) + h
--
--   Move window one screen (monitor) to the left.
--
hs.hotkey.bind(bind_threekey, "h", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenWest()
end)

--
-- ( 3 key ) + j
--
--   Move window one screen (monitor) below.
--
hs.hotkey.bind(bind_threekey, "j", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenSouth()
end)

--
-- ( 3 key ) + k
--
--   Move window one screen (monitor) above.
--
hs.hotkey.bind(bind_threekey, "k", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenNorth()
end)

--
-- ( 3 key ) + l
--
--   Move window one screen (monitor) to the right.
--
hs.hotkey.bind(bind_threekey, "l", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenEast()
end)

--
-- ( 1 key ) + Escape
--
--   "Lock" screen by starting the screensaver.
--
hs.hotkey.bind(bind_onekey, "Escape", function()
    hs.caffeinate.startScreensaver()
end)

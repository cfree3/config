-- ~/hammerspoon/init.lua | Curtis Free (http://curtisfree.com)
-- Configuration for the Hammerspoon macOS automation utility.

--
--  I want things to happen at the speed of water, not molasses!
--    (See https://github.com/Hammerspoon/hammerspoon/issues/923.)
--
hs.window.animationDuration = 0

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
--  ( 2 key ) + h
--
--    Move window to left half of the screen.
--
hs.hotkey.bind(bind_twokey, "h", function()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

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

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y + ( screenFrame.h / 2 )
  windowFrame.w = screenFrame.w
  windowFrame.h = screenFrame.h / 2

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

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w
  windowFrame.h = screenFrame.h / 2

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

  windowFrame.x = screenFrame.x + ( screenFrame.w / 2 )
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)

end)

--
-- ( 2 key ) + f (because I'm accustomed to it from my Slate config)
--  - OR -
-- ( 2 key ) + ; (easy)
--
--   Make window take up the entire screen (not to be confused with macOS's
--   fullscreen).
--
function windowFullScreen()

  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()

  local screen = window:screen()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)

end
hs.hotkey.bind(bind_twokey, ";", windowFullScreen)
hs.hotkey.bind(bind_twokey, "f", windowFullScreen)

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

--
-- ( 1 key ) + ;
--
--   Show a list of windows with hints for quick selection.
--
hs.hotkey.bind(bind_onekey, ";", function()
    hs.hints.style = "vimperator"
    hs.hints.fontSize = 13.0
    hs.hints.windowHints()
end)

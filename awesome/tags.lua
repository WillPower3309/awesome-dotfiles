--      ████████╗ █████╗  ██████╗ ███████╗
--      ╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝
--         ██║   ███████║██║  ███╗███████╗
--         ██║   ██╔══██║██║   ██║╚════██║
--         ██║   ██║  ██║╚██████╔╝███████║
--         ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local dir = os.getenv('HOME') .. '/.config/awesome/icons/tags/'
local apps = require("apps")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")


-- ===================================================================
-- Define tags
-- ===================================================================


local tags = {
  {
    icon = dir .. 'terminal.png',
    type = 'terminal',
    screen = 1
  },
  {
    icon = dir .. 'firefox.png',
    type = 'chrome',
    screen = 1
  },
  {
    icon = dir .. 'notepad.png',
    type = 'code',
    screen = 1
  },
  {
    icon = dir .. 'folder.png',
    type = 'files',
    screen = 1
  },
  {
    icon = dir .. 'player.png',
    type = 'music',
    screen = 1
  },
  {
    icon = dir .. 'videogame.png',
    type = 'game',
    screen = 1
  },
  {
    icon = dir .. 'star.png',
    type = 'art',
    screen = 1
  },
  {
    icon = dir .. 'mail.png',
    type = 'virtualbox',
    screen = 1
  },
  {
    icon = dir .. 'spotify.png',
    type = 'any',
    screen = 1
  }
}


-- ===================================================================
-- Additional Setup
-- ===================================================================


-- define tag layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

-- apply tag settings to each tag
screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(i, {
      icon = tag.icon,
      icon_only = true,
      layout = awful.layout.suit.tile,
      screen = s,
      defaultApp = tag.defaultApp,
      selected = i == 1
    })
  end
end)

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
  local currentLayout = awful.tag.getproperty(t, 'layout')
  if (currentLayout == awful.layout.suit.max) then
    t.gap = 0
  else
    t.gap = beautiful.useless_gap
  end
end)

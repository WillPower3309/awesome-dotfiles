-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons/tags/'
local apps = require("apps")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- define tag values
local tags = {
  {
    icon = dir .. 'terminal.svg',
    type = 'terminal',
    defaultApp = apps.terminal,
    screen = 1
  },
  {
    icon = dir .. 'google-chrome.svg',
    type = 'chrome',
    defaultApp = apps.browser,
    screen = 1
  },
  {
    icon = dir .. 'code-braces.svg',
    type = 'code',
    defaultApp = apps.editor,
    screen = 1
  },
  {
    icon = dir .. 'folder.svg',
    type = 'files',
    defaultApp = apps.filebrowser,
    screen = 1
  },
  {
    icon = dir .. 'music.svg',
    type = 'music',
    defaultApp = apps.musicPlayer,
    screen = 1
  },
  {
    icon = dir .. 'google-controller.svg',
    type = 'game',
    defaultApp = apps.gameLauncher,
    screen = 1
  },
  {
    icon = dir .. 'art.svg',
    type = 'art',
    defaultApp = apps.imageEditor,
    screen = 1
  },
  {
    icon = dir .. 'vbox.svg',
    type = 'virtualbox',
    defaultApp = apps.virtualMachineLauncher,
    screen = 1
  },
  {
    icon = dir .. 'flask.svg',
    type = 'any',
    defaultApp = '',
    screen = 1
  }
}

-- Define window layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(
      i,
      {
        icon = tag.icon,
        icon_only = true,
        layout = awful.layout.suit.tile,
        screen = s,
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
  end
end)

-- remove gaps if layout is set to max
_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = beautiful.useless_gap
    end
  end
)
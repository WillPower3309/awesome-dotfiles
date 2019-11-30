--      ██████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗  
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝  
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Import rules
awful.rules.rules = require("rules");

-- Import keybinds
local keys = require("keys")

-- Set Wallpaper
require("wallpaper")

-- Import Components
require("components.notifications") -- startup error handling done in here
require("components.panels")
require("components.exit-screen")
require("components.brightness-osd")
require("components.volume-osd")


-- ===================================================================
-- Layouts
-- ===================================================================


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max
}


-- ===================================================================
-- Tags
-- ===================================================================


-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons/tags/'

local tags = {
  {
    icon = dir .. 'terminal.svg',
    type = 'terminal',
    defaultApp = 'kitty',
    screen = 1
  },
  {
    icon = dir .. 'google-chrome.svg',
    type = 'chrome',
    defaultApp = 'firefox',
    screen = 1
  },
  {
    icon = dir .. 'code-braces.svg',
    type = 'code',
    defaultApp = 'atom',
    screen = 1
  },
  {
    icon = dir .. 'folder.svg',
    type = 'files',
    defaultApp = 'nemo',
    screen = 1
  },
  {
    icon = dir .. 'music.svg',
    type = 'music',
    defaultApp = 'kitty -e ncmpcpp',
    screen = 1
  },
  {
    icon = dir .. 'google-controller.svg',
    type = 'game',
    defaultApp = 'supertuxkart',
    screen = 1
  },
  {
    icon = dir .. 'art.svg',
    type = 'art',
    defaultApp = 'gimp',
    screen = 1
  },
  {
    icon = dir .. 'vbox.svg',
    type = 'virtualbox',
    defaultApp = 'virtualbox',
    screen = 1
  },
  {
    icon = dir .. 'flask.svg',
    type = 'any',
    defaultApp = '',
    screen = 1
  }
}

awful.layout.layouts = {
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.tile,
  awful.layout.suit.max
}


screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(
      i,
      {
        icon = tag.icon,
        icon_only = true,
        layout = awful.layout.suit.spiral.dwindle,
        gap_single_client = false,
        gap = 4,
        screen = s,
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
  end
end)


_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)


-- ===================================================================
-- Signals
-- ===================================================================


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


-- ===================================================================
-- Garbage collection (Enable for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

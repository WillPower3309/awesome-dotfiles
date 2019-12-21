--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
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

local config_dir = gears.filesystem.get_configuration_dir()
require("awful.autofocus")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(config_dir .. "theme.lua")

-- Import rules
awful.rules.rules = require("rules")

-- Import keybinds
local keys = require("keys")

-- Set Wallpaper
gears.wallpaper.maximized(config_dir .. "/wallpaper.jpg")

-- Import Components
require("components.notifications") -- startup error handling done in here
require("components.panels")
require("components.round-corners")
require("components.exit-screen")
require("components.brightness-osd")
require("components.volume-osd")

-- Run blur wallpaper script
awful.spawn.with_shell("sh " .. config_dir .. "/components/wallblur.sh -i ~/.config/awesome/wallpaper.jpg")

-- Import Tag Settings
require("tags")


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

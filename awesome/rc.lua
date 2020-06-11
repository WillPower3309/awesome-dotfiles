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

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Notification library
require("components.notifications")

-- Import Tag Settings
local tags = require("tags")

-- Import Components
require("components.exit-screen")
require("components.wallpaper")

-- Autostart specified apps
local apps = require("apps")
apps.autostart()


-- ===================================================================
-- Set Up Screen
-- ===================================================================


-- define tag layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
}

-- Set up each screen
local top_panel = require("components.top-panel")
local left_panel = require("components.left-panel")

awful.screen.connect_for_each_screen(function(s)
   for i, tag in pairs(tags) do
      awful.tag.add(i, {
         icon = tag.icon,
         icon_only = true,
         layout = awful.layout.suit.tile,
         screen = s,
         selected = i == 1
      })
   end

   s.top_panel = top_panel.create(s)
   s.left_panel = left_panel.create(s)
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   -- Set the window as a slave (put it at the end of others instead of setting it master)
   if not awesome.startup then
      awful.client.setslave(c)
   end

   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)

-- Enable sloppy focus, so that focus follows mouse.
require("awful.autofocus")
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


-- ===================================================================
-- Garbage collection (Allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

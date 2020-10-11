--      ████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
--      ╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
--         ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
--         ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
--         ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
--         ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi


-- ===================================================================
-- Titlebar Creation
-- ===================================================================


-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
   local titlebar = awful.titlebar(c, {
      size = dpi(30)
   })

   titlebar: setup {
      {
         -- AwesomeWM native buttons (images loaded from theme)
         wibox.layout.margin(awful.titlebar.widget.closebutton(c), dpi(11), dpi(5), dpi(5), dpi(5)),
         wibox.layout.margin(awful.titlebar.widget.minimizebutton(c), dpi(4), dpi(5), dpi(5), dpi(5)),
         wibox.layout.margin(awful.titlebar.widget.maximizedbutton(c), dpi(4), dpi(5), dpi(5), dpi(5)),
         layout = wibox.layout.fixed.horizontal
      },
      nil,
      nil,
      layout = wibox.layout.align.horizontal
   }
end)

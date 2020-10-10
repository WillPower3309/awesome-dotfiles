local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
   awful.titlebar(c) : setup {
      {
         -- AwesomeWM native buttons (images loaded from theme)
         wibox.layout.margin(awful.titlebar.widget.closebutton(c), dpi(8), dpi(3), dpi(3), dpi(3)),
         wibox.layout.margin(awful.titlebar.widget.minimizebutton(c), dpi(3), dpi(3), dpi(3), dpi(3)),
         wibox.layout.margin(awful.titlebar.widget.maximizedbutton(c), dpi(3), dpi(3), dpi(3), dpi(3)),
         layout = wibox.layout.fixed.horizontal
      },
      {
         align = "center",
         widget = awful.titlebar.widget.titlewidget(c)
      },
      nil,
      layout = wibox.layout.align.horizontal
   }
end)

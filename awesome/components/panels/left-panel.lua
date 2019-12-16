local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local gears = require('gears')

local TagList = require('widgets.tag-list')

awful.screen.connect_for_each_screen(function(s)
  s.left_panel = awful.wibar({
    position = "left",
    screen = s,
    width = dpi(45),
    height = s.geometry.height  * 2/3,
    shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 10)
    end
  })

  s.left_panel:setup {
    layout = wibox.layout.align.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      --require("widgets.launcher-button"),
      -- add taglist widget
      TagList(s),
      -- add folders widget
      require("widgets.xdg-folders"),
    },
  }
end)
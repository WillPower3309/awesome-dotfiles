local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local mat_list_item = require('widgets.list-item')

local quickTitle = wibox.widget {
  text = 'Quick Settings',
  font = 'SF Display 12',
  align = 'center',
  widget = wibox.widget.textbox
}

local barColor = beautiful.bg_normal
local volSlider = require('widgets.volume.volume-slider')
local brightnessSlider = require('widgets.brightness.brightness-slider')

return wibox.widget {
  layout = wibox.layout.fixed.vertical,
  {
    {
      quickTitle,
      bg = "#ffffff10",
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, beautiful.rounded_corner_radius) end,
      widget = wibox.container.background,
    },
    widget = mat_list_item,
  },
  {
    layout = wibox.layout.fixed.vertical,
    {
      {
        volSlider,
        bg = barColor,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.rounded_corner_radius) end,
        widget = wibox.container.background
      },
      widget = mat_list_item
    }
  },

  layout = wibox.layout.fixed.vertical,
  {
    {
      brightnessSlider,
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, beautiful.rounded_corner_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  }
}

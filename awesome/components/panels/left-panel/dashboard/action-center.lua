local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local mat_list_item = require('widgets.list-item')

local actionTitle = wibox.widget {
  text = 'Action Center',
  font = 'SF Display 12',
  align = 'center',
  widget = wibox.widget.textbox
}

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/icons/'
local checker

local barColor = beautiful.bg_normal

return wibox.widget{
  spacing = 0,
  layout = wibox.layout.fixed.vertical,
  {
    {
      actionTitle,
      bg = "#ffffff15",
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, beautiful.rounded_corner_radius) end,
      widget = wibox.container.background,
    },
    widget = mat_list_item,
  },

  {
    {
      require('widgets.action-center.wifi-button'),
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.rounded_corner_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },

  -- Bluetooth Connection
  layout = wibox.layout.fixed.vertical,
  {
    {
      require('widgets.action-center.bluetooth-button'),
      bg = barColor,
      shape = function(cr, width, height)
         gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.rounded_corner_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  }
}

local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local mat_list_item = require('widgets.list-item')

local barColor = beautiful.bg_modal

local hardwareTitle = wibox.widget
{
  text = 'Hardware Monitor',
  font = 'SF Display 12',
  align = 'center',
  widget = wibox.widget.textbox

}

return wibox.widget {
  layout = wibox.layout.fixed.vertical,
  {
    {
      hardwareTitle,
      bg = beautiful.bg_modal_title,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, beautiful.modal_radius) end,
      widget = wibox.container.background,
    },
    widget = mat_list_item,
  },
  {
    {
      require('widgets.hardware-monitor.cpu-meter'),
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.modal_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  {
    {
      require('widgets.hardware-monitor.ram-meter'),
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.modal_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  layout = wibox.layout.fixed.vertical,
  {
    {
      require('widgets.hardware-monitor.temperature-meter'),
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, beautiful.modal_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  {
    {
      require('widgets.hardware-monitor.harddrive-meter'),
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, beautiful.modal_radius) end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
}

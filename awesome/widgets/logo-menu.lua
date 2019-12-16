local awful = require('awful')
local wibox = require('wibox')
local clickable_container = require('widgets.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('icons')

local widget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

widget.icon:set_image(icons.arch)

local widget_button = clickable_container(wibox.container.margin(widget, dpi(7), dpi(7), dpi(7), dpi(7)))
widget_button:buttons(
  gears.table.join(
    -- spawn menu when clicked
    awful.button({}, 1,
      function()
        mymainmenu:toggle()
      end
    )
  )
)

return widget_button
local mat_icon = require('widgets.icon')
local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('icons')
local wibox = require('wibox')
local TagList = require('widgets.tag-list')
local clickable_container = require('widgets.clickable-container')

return function(screen, panel, action_bar_width)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

local separator =  wibox.widget
{
  orientation = 'horizontal',
  forced_height = dpi(1),
  opacity = 0.20,
  widget = wibox.widget.separator
}

return wibox.widget {
    id = 'action_bar',
    layout = wibox.layout.align.vertical,
    forced_width = action_bar_width,
    {
      -- Create a taglist widget
      TagList(screen),
      require("widgets.xdg-folders"),
      layout = wibox.layout.fixed.vertical,

    },

    nil,
    {
      LayoutBox(s),
      layout = wibox.layout.fixed.vertical,
    }
  }
end

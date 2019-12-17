local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local gears = require('gears')
local mat_icon = require('widgets.icon')
local clickable_container = require('widgets.clickable-container')
local apps = require('apps')
local icons = require('icons')

  local menu_icon = wibox.widget {
    icon = icons.menu,
    size = dpi(30),
    widget = mat_icon
  }
  
  local home_button = wibox.widget {
    wibox.widget {
      menu_icon,
      widget = clickable_container
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }
  
  home_button:buttons(
    gears.table.join(
      awful.button({}, 1,
        nil,
        function()
            awful.spawn(apps.launcher)
        end
      )
    )
  )

return menu_icon
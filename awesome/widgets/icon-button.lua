local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widgets.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

function build(imagebox, args)
  return wibox.widget {
    wibox.widget {
      wibox.widget {
        imagebox,
        top = dpi(6),
        left = dpi(6),
        right = dpi(6),
        bottom = dpi(6),
        widget = wibox.container.margin
      },
      shape = gears.shape.circle,
      widget = clickable_container
    },
    top = dpi(6),
    left = dpi(6),
    right = dpi(6),
    bottom = dpi(6),
    widget = wibox.container.margin
  }
end

return build

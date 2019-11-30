local wibox = require('wibox')
local mat_list_item = require('widgets.list-item')
local mat_slider = require('widgets.slider')
local mat_icon = require('widgets.icon')
local icons = require('icons')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

local slider =
  wibox.widget {
  read_only = true,
  widget = mat_slider
}

watch(
  [[bash -c "df -h /home|grep '^/' | awk '{print $5}'"]],
  10,
  function(_, stdout)
    local space_consumed = stdout:match('(%d+)')
    slider:set_value(tonumber(space_consumed))
    collectgarbage('collect')
  end
)

local harddrive_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.harddisk,
    size = dpi(24),
    widget = mat_icon
  },
  slider,
  widget = mat_list_item
}

return harddrive_meter
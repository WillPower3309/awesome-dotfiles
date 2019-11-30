local wibox = require('wibox')
local mat_list_item = require('widgets.list-item')
local mat_slider = require('widgets.slider')
local mat_icon_button = require('widgets.icon-button')
local clickable_container = require('widgets.clickable-container')
local icons = require('icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')
local awful = require('awful')

local slider =
  wibox.widget {
  read_only = false,
  widget = mat_slider
}

slider:connect_signal(
  'property::value',
  function()
    spawn('xbacklight -set ' .. math.max(slider.value, 5))
  end
)

watch(
  [[bash -c "xbacklight -get"]],
  2,
  function(widget, stdout, stderr, exitreason, exitcode)
    local brightness = string.match(stdout, '(%d+)')

    slider:set_value(tonumber(brightness))
    collectgarbage('collect')
  end
)

function UpdateBrOSD()
  awful.spawn.easy_async_with_shell("xbacklight -get", function( stdout )
    local brightness = string.match(stdout, '(%d+)')
    slider:set_value(tonumber(brightness))
  end)
end


local icon =
  wibox.widget {
  image = icons.brightness,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local brightness_setting =
  wibox.widget {
  button,
  slider,
  widget = mat_list_item
}

return brightness_setting
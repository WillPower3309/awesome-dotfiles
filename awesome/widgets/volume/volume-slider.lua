local wibox = require('wibox')
local mat_list_item = require('widgets.list-item')
local mat_slider = require('widgets.slider')
local mat_icon_button = require('widgets.icon-button')
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
    spawn('amixer -D pulse sset Master ' .. slider.value .. '%')
  end
)

watch(
  [[bash -c "amixer -D pulse sget Master"]],
  2,
  function(_, stdout)
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    slider:set_value(tonumber(volume))
    collectgarbage('collect')
  end
)

function UpdateVolOSD()
  awful.spawn.easy_async_with_shell("bash -c 'amixer -D pulse sget Master'", function( stdout )
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    slider:set_value(tonumber(volume))
  end)
end

local icon =
  wibox.widget {
  image = icons.volume,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local volume_setting =
  wibox.widget {
  button,
  slider,
  widget = mat_list_item
}

return volume_setting
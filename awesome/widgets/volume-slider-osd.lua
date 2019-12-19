
local wibox = require('wibox')
local mat_list_item = require('widgets.list-item')
local mat_slider = require('widgets.slider')
local mat_icon_button = require('widgets.icon-button')
local icons = require('icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')
local awful = require('awful')

local slider_osd =
  wibox.widget {
  read_only = false,
  widget = mat_slider
}

slider_osd:connect_signal(
  'property::value',
  function()
    spawn('amixer -D pulse sset Master ' .. slider_osd.value .. '%', false)
  end
)


-- A hackish way for the OSD not to hide
-- when the user is dragging the slider
-- Slider or the handle does not have a
-- Signal that handles the 'on drag' event
-- So here we are.
slider_osd:connect_signal(
  'button::press',
  function()
    slider_osd:connect_signal(
      'property::value',
      function()
        toggleVolOSD(true)
      end
    )
  end
)

function UpdateVolOSD()
  awful.spawn.easy_async_with_shell("bash -c 'amixer -D pulse sget Master'", function( stdout )
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    slider_osd:set_value(tonumber(volume))
  end, false)
end

local icon =
  wibox.widget {
  image = icons.volume,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local volume_setting_osd =
  wibox.widget {
  button,
  slider_osd,
  widget = mat_list_item
}

return volume_setting_osd
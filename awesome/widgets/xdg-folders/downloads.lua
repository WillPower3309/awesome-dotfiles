local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widgets.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

local filebrowser = require('apps').filebrowser

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/icons/folders/'

local dlWidget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local downloads_button = clickable_container(wibox.container.margin(dlWidget, dpi(8), dpi(8), dpi(8), dpi(8)))
downloads_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn.easy_async_with_shell(filebrowser .. " $HOME/Downloads", function(stderr) end, 1)
      end
    )
  )
)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {downloads_button},
    mode = 'outside',
    align = 'right',
    timer_function = function()
      return 'Downloads'
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'}
  }
)

dlWidget.icon:set_image(PATH_TO_ICONS .. 'folder-download' .. '.png')

return downloads_button

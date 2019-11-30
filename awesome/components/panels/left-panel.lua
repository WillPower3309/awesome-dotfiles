local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local apps = require('apps')
local dpi = require('beautiful').xresources.apply_dpi

local left_panel = function(screen)
  local action_bar_width = dpi(45)
  local panel_content_width = dpi(350)

  local panel =
    wibox {
    screen = screen,
    width = action_bar_width,
    height = screen.geometry.height,
    x = screen.geometry.x,
    y = screen.geometry.y,
    ontop = true,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
  }

  panel.opened = false

  panel:struts(
    {
      left = action_bar_width
    }
  )

  local backdrop =
    wibox {
    ontop = true,
    screen = screen,
    bg = '#00000000',
    type = 'dock',
    x = screen.geometry.x,
    y = screen.geometry.y,
    width = screen.geometry.width,
    height = screen.geometry.height
  }

  backdrop:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:toggle()
        end
      )
    )
  )

local TagList = require('widgets.tag-list')

  panel:setup {
    layout = wibox.layout.align.horizontal,
    wibox.widget {
      id = 'action_bar',
      layout = wibox.layout.align.vertical,
      forced_width = action_bar_width,
      {
        -- add taglist widget
        TagList(screen),
        -- add
        require("widgets.xdg-folders"),
        layout = wibox.layout.fixed.vertical,
      },
      nil,
      {
        require("widgets.layout-box"),
        layout = wibox.layout.fixed.vertical,
      }
    }
  }
  return panel
end

return left_panel

local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local apps = require('apps')
local dpi = require('beautiful').xresources.apply_dpi

local TagList = require('widgets.tag-list')

local bar_width = dpi(45)

local left_panel = function(screen)

  local panel = wibox {
    ontop = true,
    screen = screen,
    width = bar_width,
    height = screen.geometry.height,
    x = screen.geometry.x,
    y = screen.geometry.y,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
  }

  panel.opened = false

  panel:struts({
      left = bar_width
  })

  panel:setup {
    expand = "none",
    layout = wibox.layout.align.vertical,
    nil, -- nil widget to achieve vertical alignment
    {
      layout = wibox.layout.fixed.vertical,
      -- add taglist widget
      TagList(screen),
      -- add folders widget
      require("widgets.xdg-folders"),
    },
    {
      layout = wibox.layout.fixed.vertical,
      require("widgets.layout-box"),
    }
  }

  return panel
end

return left_panel

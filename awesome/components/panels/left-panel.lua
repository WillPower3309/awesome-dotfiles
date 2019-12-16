local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local TagList = require('widgets.tag-list')

local bar_width = dpi(45)


local left_panel = function(screen)
  local panel = wibox {
    ontop = true,
    screen = screen,
    width = bar_width,
    height = screen.geometry.height  * 2/3,
    x = screen.geometry.x,
    y = screen.geometry.y + screen.geometry.height * 1/6,
    bg = "#00000000",
  }

  -- define space to push windows away (equal to bar length so windows dont cover panel)
  panel:struts({
    left = bar_width
  })

  panel:setup {
    {
      expand = "none",
      layout = wibox.layout.align.vertical,
      nil, -- need nil to center items
      {
        layout = wibox.layout.fixed.vertical,
        require("widgets.launcher-button"),
        -- add taglist widget
        TagList(screen),
        -- add folders widget
        require("widgets.xdg-folders"),
      },
    },
    -- The real background color
    bg = beautiful.bg_normal,
    -- The real, anti-aliased shape
    --shape = function(cr, width, height)
    --  gears.shape.rounded_rect(cr, width, height, 6)
    --end,
    widget = wibox.container.background()
  }
  return panel
end


return left_panel
local icons = require("icons")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require('beautiful')
local mat_icon = require("widgets.icon")

local dpi = beautiful.xresources.apply_dpi

local menu_icon = wibox.widget {
    icon = icons.menu,
    size = dpi(24),
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
            function()
                panel:toggle()
            end
        )
    )
)

return home_button
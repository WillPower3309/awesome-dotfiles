local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi


local separator =  wibox.widget
  {
    orientation = 'horizontal',
    forced_height = dpi(16),
    opacity = 0.20,
    widget = wibox.widget.separator
  }

return wibox.widget {
  layout = wibox.layout.align.vertical,
  {
    separator,
    require("widgets.xdg-folders.home"),
    require("widgets.xdg-folders.documents"),
    require("widgets.xdg-folders.downloads"),
    separator,
    require("widgets.xdg-folders.trash"),
    layout = wibox.layout.fixed.vertical,

  },

}

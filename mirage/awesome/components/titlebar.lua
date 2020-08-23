-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")


-- ===================================================================
-- Titlebar Setup
-- ===================================================================

client.connect_signal("request::titlebars", function(c)
   -- buttons for the titlebar
   local buttons = gears.table.join(
      awful.button({ }, 1, function()
         c:emit_signal("request::activate", "titlebar", {raise = true})
         awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
         c:emit_signal("request::activate", "titlebar", {raise = true})
         awful.mouse.client.resize(c)
      end)
   )

   awful.titlebar(c): setup {
      -- Left
      {
         awful.titlebar.widget.closebutton(c),
         awful.titlebar.widget.maximizedbutton(c),
         awful.titlebar.widget.minimizebutton(c),
         layout = wibox.layout.fixed.horizontal
      },
      -- Middle
      {
         -- Title
         {
             align  = 'center',
             widget = awful.titlebar.widget.titlewidget(c)
         },
         buttons = buttons,
         layout = wibox.layout.flex.horizontal
      },
      -- Right
      nil,
      layout = wibox.layout.align.horizontal
   }
end)


-- ===================================================================
-- Show / Hide Titlebars
-- ===================================================================


-- Catch the Signal when a client is created
client.connect_signal("manage", function(c)

  -- Center all clients with skip_center property on spawn
  if c.floating and not c.skip_center then
    awful.placement.centered(c)
  end

  -- Hide bars when client and layout is maximized
  if not c.max then
    awful.titlebar.show(c, 'top')
  else
    awful.titlebar.hide(c, 'top')
  end

end)

-- Catch the signal when a client's layout is changed
screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    if c.floating and c.first_tag.layout.name ~= 'max' then
      if not c.hide_titlebars then
        awful.titlebar.show(c, 'top')
      else
        awful.titlebar.hide(c, 'top')
      end
    elseif c.first_tag.layout.name == 'max' and not c.fullscreen then
      awful.titlebar.hide(c, 'top')
    end
  end
end)

--      ███████╗██╗  ██╗██╗████████╗    ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗
--      ██╔════╝╚██╗██╔╝██║╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║
--      █████╗   ╚███╔╝ ██║   ██║       ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║
--      ██╔══╝   ██╔██╗ ██║   ██║       ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║
--      ███████╗██╔╝ ██╗██║   ██║       ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║
--      ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝

-- ===================================================================
-- Imports
-- ===================================================================


local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local icons = require('icons')
local clickable_container = require('widgets.clickable-container')
local apps = require('apps')
local dpi = require('beautiful').xresources.apply_dpi


-- ===================================================================
-- Appearance
-- ===================================================================


local icon_size = dpi(90)

local buildButton = function(icon)
  local abutton =
    wibox.widget {
    wibox.widget {
      wibox.widget {
        wibox.widget {
          image = icon,
          widget = wibox.widget.imagebox
        },
        top = dpi(16),
        bottom = dpi(16),
        left = dpi(16),
        right = dpi(16),
        widget = wibox.container.margin
      },
      shape = gears.shape.circle,
      forced_width = icon_size,
      forced_height = icon_size,
      widget = clickable_container
    },
    left = dpi(24),
    right = dpi(24),
    widget = wibox.container.margin
  }

  return abutton
end


-- ===================================================================
-- Functionality
-- ===================================================================


function suspend_command()
  exit_screen_hide()
  awful.spawn.with_shell(apps.lock .. ' & systemctl suspend')
end

function exit_command()
  awesome.quit()
end

function lock_command()
  exit_screen_hide()
  awful.spawn.with_shell('sleep 1 && ' .. apps.lock)
end

function poweroff_command()
  awful.spawn.with_shell('poweroff')
  awful.keygrabber.stop(exit_screen_grabber)
end

function reboot_command()
  awful.spawn.with_shell('reboot')
  awful.keygrabber.stop(exit_screen_grabber)
end

local poweroff = buildButton(icons.power, 'Shutdown')
poweroff:connect_signal(
  'button::release',
  function()
    poweroff_command()
  end
)

local reboot = buildButton(icons.restart, 'Restart')
reboot:connect_signal(
  'button::release',
  function()
    reboot_command()
  end
)

local suspend = buildButton(icons.sleep, 'Sleep')
suspend:connect_signal(
  'button::release',
  function()
    suspend_command()
  end
)

local exit = buildButton(icons.logout, 'Logout')
exit:connect_signal(
  'button::release',
  function()
    exit_command()
  end
)

local lock = buildButton(icons.lock, 'Lock')
lock:connect_signal(
  'button::release',
  function()
    lock_command()
  end
)


-- ===================================================================
-- Create Widget
-- ===================================================================


local screen_geometry = awful.screen.focused().geometry

-- Create the widget
exit_screen =
  wibox(
  {
    x = screen_geometry.x,
    y = screen_geometry.y,
    visible = false,
    ontop = true,
    type = 'splash',
    height = screen_geometry.height,
    width = screen_geometry.width
  }
)

-- define exit screen foreground and background
exit_screen.bg = beautiful.bg_normal
exit_screen.fg = '#FEFEFE'

local exit_screen_grabber

function exit_screen_hide()
  awful.keygrabber.stop(exit_screen_grabber)
  exit_screen.visible = false
end

function exit_screen_show()
  exit_screen_grabber =
    awful.keygrabber.run(
    function(_, key, event)
      if event == 'release' then
        return
      end

      if key == 's' then
        suspend_command()
      elseif key == 'e' then
        exit_command()
      elseif key == 'l' then
        lock_command()
      elseif key == 'p' then
        poweroff_command()
      elseif key == 'r' then
        reboot_command()
      elseif key == 'Escape' or key == 'q' or key == 'x' then
        exit_screen_hide()
      end
    end
  )
  exit_screen.visible = true
end

exit_screen:buttons(
  gears.table.join(
    -- Middle click - Hide exit_screen
    awful.button(
      {},
      2,
      function()
        exit_screen_hide()
      end
    ),
    -- Right click - Hide exit_screen
    awful.button(
      {},
      3,
      function()
        exit_screen_hide()
      end
    )
  )
)

-- Item placement
exit_screen:setup {
  nil,
  {
    nil,
    {
      poweroff,
      reboot,
      suspend,
      exit,
      lock,
      layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.horizontal
  },
  nil,
  expand = 'none',
  layout = wibox.layout.align.vertical
}

--      ██╗  ██╗███████╗██╗   ██╗███████╗
--      ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--      █████╔╝ █████╗   ╚████╔╝ ███████╗
--      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--      ██║  ██╗███████╗   ██║   ███████║
--      ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Default Applications
local apps = require("apps");

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"

local keys = {}


-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================


-- Move client to given direction
local function move_client(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        local workarea = awful.screen.focused().workarea
        if direction == "up" then
            c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
        elseif direction == "down" then
            c:geometry({ nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil })
        elseif direction == "left" then
            c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
        elseif direction == "right" then
            c:geometry({ x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil })
        end
    -- Otherwise swap the client in the tiled layout
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end


-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0,  0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0,  0, 0,  floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0,  0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0,  0,  floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact( tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact( tiling_resize_factor)
        end
    end
end


-- ===================================================================
-- Mouse bindings
-- ===================================================================


-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(
    -- left click on desktop to hide notification
    awful.button({}, 1,
        function ()
            naughty.destroy_all_notifications()
        end
    )
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
    -- Raise client
    awful.button({}, 1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),

    -- Move and Resize Client
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)


-- ===================================================================
-- Desktop Key bindings
-- ===================================================================


keys.globalkeys = gears.table.join(
    -- =========================================
    -- APPLICATION KEY BINDINGS
    -- =========================================

    -- Spawn terminal
    awful.key({ modkey }, "Return",
        function ()
            awful.spawn(apps.terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    -- launch rofi
    awful.key({ modkey }, "d",
        function()
            awful.spawn(apps.launcher)
        end,
        {description = "application launcher", group = "launcher"}
    ),

    -- =========================================
    -- VOLUME / BRIGHTNESS / SCREENSHOT
    -- =========================================

    -- Brightness
    awful.key({}, 'XF86MonBrightnessUp',
        function()
            awful.spawn('xbacklight -inc 10')
            if toggleBriOSD ~= nil then
                toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                UpdateBriOSD()
            end
        end,
        {description = '+10%', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86MonBrightnessDown',
        function()
            awful.spawn('xbacklight -dec 10')
            if toggleBriOSD ~= nil then
                toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                UpdateBriOSD()
            end
        end,
        {description = '-10%', group = 'hotkeys'}
    ),

    -- ALSA volume control
    awful.key({}, 'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+')
            if toggleVolOSD ~= nil then
                toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                UpdateVolOSD()
            end
        end,
        {description = 'volume up', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-')
            if toggleVolOSD ~= nil then
                toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                UpdateVolOSD()
            end
        end,
        {description = 'volume down', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle')
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioNext',
        function()
            awful.spawn('mpc next')
        end,
        {description = 'next music', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioPrev',
        function()
            awful.spawn('mpc prev')
        end,
        {description = 'previous music', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle')
        end,
        {description = 'play/pause music', group = 'hotkeys'}
    ),

    -- Screenshot on prtscn using scrot
    awful.key({}, "Print",
        function ()
            awful.util.spawn(apps.screenshot, false)
        end
    ),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}
    ),

    -- Focus client by direction (arrow keys)
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}
    ),

    -- Focus client by index (cycle through clients)
    awful.key({ modkey }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================

    -- Reload Awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),

    -- Quit Awesome
    awful.key({ modkey }, "Escape",
        function()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}
    ),

    awful.key({}, 'XF86PowerOff',
        function()
            exit_screen_show()
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),

    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key({ modkey, "Shift" }, "minus",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ modkey }, "minus",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),

    -- =========================================
    -- CLIENT RESIZING
    -- =========================================
    awful.key({ modkey, "Control" }, "Down", function (c)
        resize_client(client.focus, "down")
    end),
    awful.key({ modkey, "Control" }, "Up", function (c)
        resize_client(client.focus, "up")
    end),
    awful.key({ modkey, "Control" }, "Left", function (c)
        resize_client(client.focus, "left")
    end),
    awful.key({ modkey, "Control" }, "Right", function (c)
        resize_client(client.focus, "right")
    end),
    awful.key({ modkey, "Control" }, "j", function (c)
        resize_client(client.focus, "down")
    end),
    awful.key({ modkey, "Control" }, "k", function (c)
        resize_client(client.focus, "up")
    end),
    awful.key({ modkey, "Control" }, "h", function (c)
        resize_client(client.focus, "left")
    end),
    awful.key({ modkey, "Control" }, "l", function (c)
        resize_client(client.focus, "right")
    end),

    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================

    -- Number of master clients
    awful.key({ modkey, altkey }, "h",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "l",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Left",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Right",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),

    -- Number of columns
    awful.key({ modkey, altkey }, "k",
        function ()
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "j",
        function ()
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Up",
        function ()
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Down",
        function ()
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),

    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key({ modkey }, "space",
        function ()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    -- select previous layout
    awful.key({ modkey, "Shift" }, "space",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),

    -- =========================================
    -- CLIENT CONTROL
    -- =========================================

    -- restore minimized client
    awful.key({ modkey, "Shift" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    )
)


-- ===================================================================
-- Client Key bindings
-- ===================================================================


keys.clientkeys = gears.table.join(
    -- Move to edge or swap by direction
    awful.key({ modkey, "Shift" }, "Down", function (c)
        move_client(c, "down")
    end),
    awful.key({ modkey, "Shift" }, "Up", function (c)
        move_client(c, "up")
    end),
    awful.key({ modkey, "Shift" }, "Left", function (c)
        move_client(c, "left")
    end),
    awful.key({ modkey, "Shift" }, "Right", function (c)
        move_client(c, "right")
    end),
    awful.key({ modkey, "Shift" }, "j", function (c)
        move_client(c, "down")
    end),
    awful.key({ modkey, "Shift" }, "k", function (c)
        move_client(c, "up")
    end),
    awful.key({ modkey, "Shift" }, "h", function (c)
        move_client(c, "left")
    end),
    awful.key({ modkey, "Shift" }, "l", function (c)
        move_client(c, "right")
    end),

    -- toggle fullscreen
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),

    -- close client
    awful.key({ modkey }, "q",
        function (c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),

    -- Minimize
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),

    -- Maximize
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

-- Bind all key numbers to tags
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

return keys

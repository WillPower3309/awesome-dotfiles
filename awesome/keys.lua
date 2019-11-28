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

-- Default Applications
apps = require("apps");

-- Define mod key
modkey = "Mod4"
altkey = "Mod1"

local keys = {}


-- ===================================================================
-- Mouse bindings
-- ===================================================================


keys.desktopbuttons = gears.table.join()


-- ===================================================================
-- Key bindings
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
        {description = "open a terminal", group = "launcher"}),
    -- launch rofi
    awful.key({ modkey }, "d",
        function()
            awful.spawn(apps.launcher)
        end,
        {description = "application launcher", group = "launcher"}),

    -- =========================================
    -- VOLUME / BRIGHTNESS
    -- =========================================

    -- Brightness
    awful.key({}, 'XF86MonBrightnessUp',
        function()
            awful.spawn('xbacklight -inc 10')
            if toggleBriOSD ~= nil then
                _G.toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                _G.UpdateBrOSD()
            end
        end,
        {description = '+10%', group = 'hotkeys'}),
    awful.key({}, 'XF86MonBrightnessDown',
        function()
            awful.spawn('xbacklight -dec 10')
            if toggleBriOSD ~= nil then
                _G.toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                _G.UpdateBrOSD()
            end
        end,
        {description = '-10%', group = 'hotkeys'}),

    -- ALSA volume control
    awful.key({}, 'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+')
            if toggleVolOSD ~= nil then
                _G.toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                _G.UpdateVolOSD()
            end
        end,
        {description = 'volume up', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-')
            if toggleVolOSD ~= nil then
                _G.toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                 _G.UpdateVolOSD()
            end
        end,
        {description = 'volume down', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle')
        end,
        {description = 'toggle mute', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioNext',
        function()
            awful.spawn('mpc next')
        end,
        {description = 'next music', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioPrev',
        function()
            awful.spawn('mpc prev')
        end,
        {description = 'previous music', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle')
        end,
        {description = 'play/pause music', group = 'hotkeys'}),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- Focus client by direction (arrow keys)
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- Focus client by index (cycle through clients)
    awful.key({ modkey }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}),

    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================

    -- Reload Awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome
    awful.key({ modkey }, "Escape",
        function()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),

    awful.key({}, 'XF86PowerOff',
        function()
            exit_screen_show()
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}),

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
    -- CLIENT RESIZING (TODO)
    -- =========================================

    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================

    -- Number of master clients
    awful.key({ modkey, altkey }, "h",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey }, "l",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey }, "Left",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey }, "Right",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}),

    -- Number of columns
    awful.key({ modkey, altkey }, "k",
        function ()
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, altkey }, "j",
        function ()
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, altkey }, "Up",
        function ()
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, altkey }, "Down",
        function ()
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    
    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key({ modkey }, "space",
        function ()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}),
    -- select previous layout
    awful.key({ modkey, "Shift" }, "space",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}),
    
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
        {description = "restore minimized", group = "client"})
)


keys.clientkeys = gears.table.join(
    -- toggle fullscreen
    awful.key({ modkey }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),

    -- close client
        awful.key({ modkey }, "q",
    function (c)
        c:kill()
    end,
    {description = "close", group = "client"}),

    -- center client 
    --awful.key({ modkey }, "c", function (c)
    --    awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
    --    helpers.single_double_tap(
    --        nil,
    --        function ()
    --            helpers.float_and_resize(c, screen_width * 0.65, screen_height * 0.9)
    --        end
    --    )
    --end),

    -- toggle floating
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),

    -- Move to edge or swap by direction
    --awful.key({ modkey, "Shift" }, "Down", function (c)
    --    helpers.move_client_dwim(c, "down")
    --end),
    --awful.key({ modkey, "Shift" }, "Up", function (c)
    --    helpers.move_client_dwim(c, "up")
    --end),
    --awful.key({ modkey, "Shift" }, "Left", function (c)
    --    helpers.move_client_dwim(c, "left")
    --end),
    --awful.key({ modkey, "Shift" }, "Right", function (c)
    --    helpers.move_client_dwim(c, "right")
    --end),
    --awful.key({ modkey, "Shift" }, "j", function (c)
    --    helpers.move_client_dwim(c, "down")
    --end),
    --awful.key({ modkey, "Shift" }, "k", function (c)
    --    helpers.move_client_dwim(c, "up")
    --end),
    --awful.key({ modkey, "Shift" }, "h", function (c)
    --    helpers.move_client_dwim(c, "left")
    --end),
    --awful.key({ modkey, "Shift" }, "l", function (c)
    --    helpers.move_client_dwim(c, "right")
    --end),

    -- Minimize
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),

    -- Maximize
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
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
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
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
                  {description = "move focused client to tag #"..i, group = "tag"}),
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
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys

--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


theme.name = "mirage"

-- Font
theme.font = "SF Pro Text 9"
theme.title_font = "SF Pro Display Medium 10"

-- Background
theme.bg_normal = "#5B60711A"
theme.bg_dark = "#090B0C"
theme.bg_focus = "#151821"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#444444"

-- Foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- Gaps
theme.useless_gap = dpi(7)
theme.gap_single_client = true

-- Corner Radius of Rounded Windows
theme.corner_radius = dpi(20)

-- Window Borders
theme.border_width = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus = "#ff8a65"
theme.border_marked = theme.fg_urgent

-- Taglist
theme.taglist_bg_empty = theme.bg_dark
theme.taglist_bg_occupied = theme.bg_dark
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_dark
theme.taglist_spacing = dpi(25)

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(60)
theme.top_panel_height = dpi(30)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.bg_systray = "#00000000"
theme.systray_icon_spacing = dpi(5)


-- ===================================================================
-- Icons
-- ===================================================================


-- Define layout icons
theme.layout_tile = "~/.config/awesome/icons/layouts/tiled.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_max = "~/.config/awesome/icons/layouts/maximized.png"

theme.icon_theme = "Tela-dark"


-- ===================================================================
-- Titlebars
-- ===================================================================


theme.titlebars_enabled = true

local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/titlebar/"

theme.titlebar_bg_focus = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg_normal = theme.fg_focus

-- Close Button
theme.titlebar_close_button_normal = icon_dir .. 'normal.svg'
theme.titlebar_close_button_focus  = icon_dir .. 'close_focus.svg'
theme.titlebar_close_button_normal_hover = icon_dir .. 'close_focus_hover.svg'
theme.titlebar_close_button_focus_hover  = icon_dir .. 'close_focus_hover.svg'

-- Minimize Button
theme.titlebar_minimize_button_normal = icon_dir .. 'normal.svg'
theme.titlebar_minimize_button_focus  = icon_dir .. 'minimize_focus.svg'
theme.titlebar_minimize_button_normal_hover = icon_dir .. 'minimize_focus_hover.svg'
theme.titlebar_minimize_button_focus_hover  = icon_dir .. 'minimize_focus_hover.svg'

-- Maximized Button (While Window is Maximized)
theme.titlebar_maximized_button_normal_active = icon_dir .. 'normal.svg'
theme.titlebar_maximized_button_focus_active  = icon_dir .. 'maximized_focus.svg'
theme.titlebar_maximized_button_normal_active_hover = icon_dir .. 'maximized_focus_hover.svg'
theme.titlebar_maximized_button_focus_active_hover  = icon_dir .. 'maximized_focus_hover.svg'

-- Maximized Button (While Window is not Maximized)
theme.titlebar_maximized_button_normal_inactive = icon_dir .. 'normal.svg'
theme.titlebar_maximized_button_focus_inactive  = icon_dir .. 'maximized_focus.svg'
theme.titlebar_maximized_button_normal_inactive_hover = icon_dir .. 'maximized_focus_hover.svg'
theme.titlebar_maximized_button_focus_inactive_hover  = icon_dir .. 'maximized_focus_hover.svg'

-- return theme
return theme

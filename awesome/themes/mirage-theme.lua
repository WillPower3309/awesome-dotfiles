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
local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/"

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
theme.bg_systray = theme.bg_normal

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
theme.taglist_bg_empty = "#000000"
theme.taglist_bg_occupied = "#111111"
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_normal

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = icon_dir .. "layouts/view-quilt.png"
theme.layout_floating = icon_dir .. "layouts/view-float.png"
theme.layout_max = icon_dir .. "layouts/arrow-expand-all.png"

theme.icon_theme = "Tela-dark"


-- ===================================================================
-- Titlebar
-- ===================================================================


theme.titlebars_enabled = true
theme.titlebar_bg_focus = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg_normal = theme.fg_focus
theme.titlebar_font = theme.title_font

-- Close Button
theme.titlebar_close_button_normal = icon_dir .. "titlebar/close_normal.svg"
theme.titlebar_close_button_focus  = icon_dir .. "titlebar/close_focus.svg"

-- Minimize Button
theme.titlebar_minimize_button_normal = icon_dir .. "titlebar/minimize_normal.svg"
theme.titlebar_minimize_button_focus  = icon_dir .. "titlebar/minimize_focus.svg"

-- Ontop Button
theme.titlebar_ontop_button_normal_inactive = icon_dir .. "titlebar/ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = icon_dir .. "titlebar/ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = icon_dir .. "titlebar/ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = icon_dir .. "titlebar/ontop_focus_active.svg"

-- Sticky Button
theme.titlebar_sticky_button_normal_inactive = icon_dir .. "titlebar/sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = icon_dir .. "titlebar/sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = icon_dir .. "titlebar/sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = icon_dir .. "titlebar/sticky_focus_active.svg"

-- Floating Button
theme.titlebar_floating_button_normal_inactive = icon_dir .. "titlebar/floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = icon_dir .. "titlebar/floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = icon_dir .. "titlebar/floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = icon_dir .. "titlebar/floating_focus_active.svg"

-- Maximized Button
theme.titlebar_maximized_button_normal_inactive = icon_dir .. "titlebar/maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = icon_dir .. "titlebar/maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = icon_dir .. "titlebar/maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = icon_dir .. "titlebar/maximized_focus_active.svg"

-- Hovered Close Button
theme.titlebar_close_button_normal_hover = icon_dir .. "titlebar/close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = icon_dir .. "titlebar/close_focus_hover.svg"

-- Hovered Minimize Buttin
theme.titlebar_minimize_button_normal_hover = icon_dir .. "titlebar/minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = icon_dir .. "titlebar/minimize_focus_hover.svg"

-- Hovered Ontop Button
theme.titlebar_ontop_button_normal_inactive_hover = icon_dir .. "titlebar/ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = icon_dir .. "titlebar/ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = icon_dir .. "titlebar/ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = icon_dir .. "titlebar/ontop_focus_active_hover.svg"

-- Hovered Sticky Button
theme.titlebar_sticky_button_normal_inactive_hover = icon_dir .. "titlebar/sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = icon_dir .. "titlebar/sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = icon_dir .. "titlebar/sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = icon_dir .. "titlebar/sticky_focus_active_hover.svg"

-- Hovered Floating Button
theme.titlebar_floating_button_normal_inactive_hover = icon_dir .. "titlebar/floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = icon_dir .. "titlebar/floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = icon_dir .. "titlebar/floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = icon_dir .. "titlebar/floating_focus_active_hover.svg"

-- Hovered Maximized Button
theme.titlebar_maximized_button_normal_inactive_hover = icon_dir .. "titlebar/maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = icon_dir .. "titlebar/maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = icon_dir .. "titlebar/maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = icon_dir .. "titlebar/maximized_focus_active_hover.svg"


-- return theme
return theme

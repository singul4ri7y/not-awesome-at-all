local add_button     = require('widget.panel.open-default-app')
local date           = require('widget.panel.date')
local tray_toggler   = require('widget.panel.tray-toggler')
local task_list      = require('widget.panel.task-list')
local layout_box     = require('widget.panel.layout-box')

return function(scr, offset) 
	if offset then
		offset = dpi(45)
	else offset = dpi(0) end

	local panel = awful.wibar {
		screen  = scr,
		type    = 'dock',
		height  = dpi(45),
		width   = scr.geometry.width - offset,
		x       = scr.geometry.x + offset,
		y       = scr.geometry.y,
		stretch = false,
		bg      = beautiful.bg_normal,
		fg      = beautiful.fg_normal
	}

	scr.systray = wibox.widget.systray {
		screen     = 'primary',
		base_size  = dpi(20),
		horizontal = true,
		visible    = true
	}

	

	panel:setup {
		layout = wibox.layout.align.horizontal,
		expand = 'none',

		-- Left widgets.

		{
			layout = wibox.layout.fixed.horizontal,
			task_list(scr),
			add_button
		},

		nil,    -- Middle widget.

		-- Right widget.

		{
			layout  = wibox.layout.fixed.horizontal,
			spacing = dpi(5),

			{
				widget = wibox.container.margin,
				left   = dpi(0),
				right  = dpi(5),
				top    = dpi(12),
				bottom = dpi(12),
				
				scr.systray
			},

			tray_toggler,
			date,
			layout_box(scr)
		}
	}

	return panel
end
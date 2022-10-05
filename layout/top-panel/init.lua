local add_button     = require('widget.panel.open-default-app')
local date           = require('widget.panel.date')
local tray_toggler   = require('widget.panel.tray-toggler')
local task_list      = require('widget.panel.task-list')

-- To toggle the right panel.

local panel_toggle   = require('layout.right-panel.panel-toggle')

return function(scr, offset) 
	local lb_widget = nil    -- Layout box widget for screen other than primary.

	if offset then
		offset = dpi(45)
	else 
		offset    = dpi(0)
		lb_widget = require('widget.panel.layout-box')(scr)
	end

	local panel = wibox {
		screen  = scr,
		type    = 'dock',
		height  = dpi(45),
		visible = true,
		ontop   = true,
		width   = scr.geometry.width - offset,
		x       = scr.geometry.x + offset,
		y       = scr.geometry.y,
		stretch = false,
		bg      = beautiful.bg_normal,
		fg      = beautiful.fg_normal
	}

	-- Panel boundary.

	panel:struts {
		top = dpi(45)
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
				widget  = wibox.container.margin,
				margins = dpi(10),
				right   = dpi(0),
				
				scr.systray
			},

			tray_toggler,
			date(scr),
			lb_widget,
			panel_toggle(scr)
		}
	}

	return panel
end

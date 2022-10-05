return function(scr)
	-- Panel width.

	local panel_width = dpi(350)

	local panel = wibox {
		ontop   = true,
		screen  = scr,
		visible = false,
		type    = 'dock',
		width   = panel_width,
		height  = scr.geometry.height - dpi(45),
		x       = scr.geometry.x + scr.geometry.width - panel_width,
		y       = scr.geometry.y + dpi(45),
		bg      = beautiful.bg_dashboard,
		fg      = beautiful.fg_normal
	}

	local backdrop = wibox {
		ontop  = true,
		screen = scr,
		bg     = beautiful.bg_backdrop,
		type   = 'utility',
		x      = scr.geometry.x,
		y      = scr.geometry.y + dpi(45),
		width  = scr.geometry.width - panel_width,
		height = scr.geometry.height - dpi(45)
	}
	
	function panel:open()
		backdrop.visible = true
		panel.visible    = true

		scr:emit_signal('widget:right_panel_toggle::opened')
	end

	function panel:close()
		panel.visible    = false
		backdrop.visible = false

		scr:emit_signal('widget:right_panel_toggle::closed')
	end

	function panel:toggle()
		if self.visible then
			panel:close()
		else
			panel:open()
		end
	end

	backdrop:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			panel:close()
		end)
	))

	scr:connect_signal('panel:right::toggle', function()
		panel:toggle()
	end)

	panel:setup {
		require('widget.panel.notification-center')(scr),

		margins = dpi(20),
		widget = wibox.container.margin
	}

	return panel
end
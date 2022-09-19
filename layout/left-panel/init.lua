local action_bar   = require('layout.left-panel.action-bar')
local dashboard    = require('layout.left-panel.dashboard')
local dashboard_ex = require('layout.left-panel.dashboard-extended')

return function(scr)
	local action_bar_width    = dpi(45)
	local panel_content_width = dpi(380)

	local panel = wibox {
		screen    = scr,
		width     = action_bar_width,
		type      = 'dock',
		opened    = false,
		opened_ex = false,
		visible   = true,
		height    = scr.geometry.height,
		x         = scr.geometry.x,
		y         = scr.geometry.y,
		ontop     = true,
		shape     = gears.shape.rectangle,
		bg        = beautiful.background,
		fg        = beautiful.fg_normal
	}

	panel:struts {
		left = action_bar_width
	}

	local backdrop = wibox {
		ontop  = true,
		screen = scr,
		bg     = beautiful.transparent,
		type   = 'utility',
		x      = action_bar_width + panel_content_width,
		y      = scr.geometry.y,
		width  = scr.geometry.width - (action_bar_width + panel_content_width),
		height = scr.geometry.height
	}

	local function open_panel()
		panel.width      = action_bar_width + panel_content_width
		panel.opened     = true
		backdrop.visible = true

		panel:get_children_by_id('panel_content')[1].visible = true

		panel:emit_signal('opened')

		-- Update display and sound contents.

		awesome.emit_signal('widget::display')
		awesome.emit_signal('widget::sound')
	end

	-- Close extended dashboard.

	local function close_panel_extended()
		panel.width     = action_bar_width + panel_content_width
		panel.opened_ex = false

		backdrop.width = scr.geometry.width - panel.width
		backdrop.x     = panel.width

		panel:get_children_by_id('panel_content_extended')[1].visible = false

		panel:emit_signal('closed_extended')
	end

	local function close_panel()
		if panel.opened_ex then
			close_panel_extended()
		end

		panel.width  = action_bar_width
		panel.opened = false
		
		panel:get_children_by_id('panel_content')[1].visible = false

		backdrop.visible = false

		panel:emit_signal('closed')
	end

	-- Open extended dashboard.

	local function open_panel_extended()
		panel.width     = action_bar_width + 2 * panel_content_width
		panel.opened_ex = true
		
		backdrop.width = scr.geometry.width - panel.width
		backdrop.x     = panel.width
		
		panel:get_children_by_id('panel_content_extended')[1].visible = true

		panel:emit_signal('opened_extended')
	end

	function panel:toggle()
		if self.opened then
			close_panel()
		else
			open_panel()
		end
	end

	function panel:toggle_extended()
		if self.opened_ex then
			close_panel_extended()
		else 
			open_panel_extended()
		end
	end

	backdrop:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			panel:toggle()
		end)
	))

	screen.connect_signal('panel:left::toggle', function() panel:toggle() end)

	screen.connect_signal('panel:left::hide', function()
		if panel.opened then
			close_panel()
		end
	end)

	panel:setup {
		layout = wibox.layout.align.horizontal,
		nil,

		{
			{
				dashboard(scr),

				id           = 'panel_content',
				bg           = beautiful.transparent,
				widget       = wibox.container.background,
				visible      = false,
				forced_width = panel_content_width
			},

			{
				dashboard_ex(scr),

				id           = 'panel_content_extended',
				bg           = beautiful.transparent,
				widget       = wibox.container.background,
				visible      = false,
				forced_width = panel_content_width_extended
			},

			layout = wibox.layout.fixed.horizontal
		},

		action_bar(scr, panel, action_bar_width)
	}

	return panel
end
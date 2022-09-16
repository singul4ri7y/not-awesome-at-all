local action_bar = require('layout.left-panel.action-bar')
local dashboard  = require('layout.left-panel.dashboard')

return function(scr)
	local action_bar_width = dpi(45)
	local panel_content_width = dpi(380)

	local panel = wibox {
		screen  = scr,
		width   = action_bar_width,
		type    = 'dock',
		visible = true,
		height  = scr.geometry.height,
		x       = scr.geometry.x,
		y       = scr.geometry.y,
		ontop   = true,
		shape   = gears.shape.rectangle,
		bg      = beautiful.background,
		fg      = beautiful.fg_normal
	}

	panel.opened = false

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

	function panel:run_rofi()
		awesome.spawn('rofi -show drun', false, false, false, false, function()
			panel:toggle()
		end)
		
		-- Hide panel content if rofi global search is opened.

		panel:get_children_by_id('panel_content')[1].visible = false
	end

	local open_panel = function(should_run_rofi)
		panel.width      = action_bar_width + panel_content_width
		backdrop.visible = true

		panel:get_children_by_id('panel_content')[1].visible = true

		if should_run_rofi then
			panel:run_rofi()
		end

		panel:emit_signal('opened')

		-- Update volume and brightness.

		awesome.emit_signal('widget::brightness')
		awesome.emit_signal('widget::volume')
	end

	local close_panel = function()
		panel.width = action_bar_width
		
		panel:get_children_by_id('panel_content')[1].visible = false

		backdrop.visible = false

		panel:emit_signal('closed')
	end

	-- Hide this panel when app dashboard is called.
	function panel:hide_dashboard()
		close_panel()
	end

	function panel:toggle(should_run_rofi)
		self.opened = not self.opened
		if self.opened then
			open_panel(should_run_rofi)
		else
			close_panel()
		end
	end

	backdrop:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			panel:toggle()
		end)
	))

	screen.connect_signal('panel:left::toggle', function() panel:toggle() end)

	panel:setup {
		layout = wibox.layout.align.horizontal,
		nil,

		{
			id           = 'panel_content',
			bg           = beautiful.transparent,
			widget       = wibox.container.background,
			visible      = false,
			forced_width = panel_content_width,

			{
				dashboard(scr, panel),
				layout = wibox.layout.stack
			}
		},

		action_bar(scr, panel, action_bar_width)
	}

	return panel
end
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
		bg        = beautiful.bg_normal,
		fg        = beautiful.fg_normal
	}

	panel:struts {
		left = action_bar_width
	}

	local backdrop = wibox {
		ontop  = true,
		screen = scr,
		bg     = beautiful.bg_backdrop,
		type   = 'utility',
		x      = action_bar_width + panel_content_width,
		y      = scr.geometry.y,
		width  = scr.geometry.width - (action_bar_width + panel_content_width),
		height = scr.geometry.height
	}

	function panel:open()
		scr.right_panel:close()

		self.width       = action_bar_width + panel_content_width
		self.opened      = true
		
		backdrop.visible = true

		self:get_children_by_id('panel_content')[1].visible = true

		self:emit_signal('opened')

		-- Update display and sound contents.

		awesome.emit_signal('widget::display')
		awesome.emit_signal('widget::sound')
	end

	-- Close extended dashboard.

	function panel:close_extended()
		self.width     = action_bar_width + panel_content_width
		self.opened_ex = false

		backdrop.width = scr.geometry.width - self.width
		backdrop.x     = self.width

		self:get_children_by_id('dashboard_margin')[1].right         = dpi(20)
		self:get_children_by_id('panel_content_extended')[1].visible = false

		self:emit_signal('closed_extended')

		awesome.emit_signal('widget::mediaplayer:close')
	end

	function panel:close()
		if self.opened_ex then
			panel:close_extended()
		end

		self.width  = action_bar_width
		self.opened = false
		
		self:get_children_by_id('panel_content')[1].visible = false

		backdrop.visible = false

		self:emit_signal('closed')
	end

	-- Open extended dashboard.

	function panel:open_extended()
		self.width     = action_bar_width + 2 * panel_content_width
		self.opened_ex = true
		
		backdrop.width = scr.geometry.width - self.width
		backdrop.x     = self.width

		self:get_children_by_id('dashboard_margin')[1].right         = dpi(10)
		self:get_children_by_id('panel_content_extended')[1].visible = true

		self:emit_signal('opened_extended')

		awesome.emit_signal('widget::mediaplayer:open')
	end

	function panel:toggle()
		if self.opened then
			panel:close()
		else
			panel:open()
		end
	end

	function panel:toggle_extended()
		if self.opened_ex then
			panel:close_extended()
		else 
			panel:open_extended()
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
			panel:close()
		end
	end)

	panel:setup {
		layout = wibox.layout.align.horizontal,
		nil,

		{
			{
				{
					dashboard(scr),

					id           = 'panel_content',
					bg           = beautiful.transparent,
					widget       = wibox.container.background,
					visible      = false,
					forced_width = panel_content_width
				},

				nil,

				{
					dashboard_ex(scr),

					id           = 'panel_content_extended',
					bg           = beautiful.transparent,
					widget       = wibox.container.background,
					visible      = false,
					forced_width = panel_content_width
				},

				layout = wibox.layout.align.horizontal
			},

			bg = beautiful.bg_dashboard,
			widget = wibox.container.background
		},

		action_bar(scr, panel, action_bar_width)
	}

	return panel
end
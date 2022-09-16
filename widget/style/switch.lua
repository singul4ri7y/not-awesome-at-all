local helpers = require('layout.helpers')

return function()
	local switch = wibox.widget {
		{
			id     = 'dot',
			markup = helpers.colorize_text('', beautiful.color_white),
			align  = 'left',
			valign = 'center',
			font   = default_font .. '16',
			widget = wibox.widget.textbox
		},

		active        = false,
		widget        = wibox.container.background,
		forced_height = dpi(20),
		forced_width  = dpi(40),
		bg            = beautiful.transparent,
		border_width  = dpi(1),
		shape         = gears.shape.rounded_rect,
		paddings      = dpi(2),
		border_color  = beautiful.color_white
	}

	function switch:on()
		self.active       = true
		self.bg           = '#5678FF'
		self.border_color = '#5678FF'

		self.dot.align  = 'right'
	end

	function switch:off()
		self.active       = false
		self.bg           = beautiful.transparent
		self.border_color = beautiful.color_white

		self.dot.align  = 'left'
	end

	function switch:toggle()
		if self.active then
			self:off()
		else self:on() end
	end

	function switch:is_active()
		return self.active
	end

	local old_cursor, old_wibox

	switch:connect_signal('mouse::enter', function()
		local w = mouse.current_wibox

		if w then
			old_cursor, old_wibox = w.cursor, w
			w.cursor = 'hand1'
		end
	end)

	switch:connect_signal('mouse::leave', function()
		if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)

	return switch
end
return function(widget) 
	local cwid = wibox.widget {
		widget,
		widget = wibox.container.background
	}

	-- Old and new widget.

	local old_cursor, old_wibox

	-- Mouse hovers on the widget.

	cwid:connect_signal('mouse::enter', function()
		cwid.bg = beautiful.widget_enter

		-- Hm, no idea how to get the wibox from this signal's arguments...

		local w = mouse.current_wibox

		if w then
			old_cursor, old_wibox = w.cursor, w
			w.cursor = 'hand1'
		end
	end)

	-- Mouse leaves the widget.

	cwid:connect_signal('mouse::leave', function()
		cwid.bg = beautiful.widget_leave

		if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)

	-- Mouse pressed the widget.

	cwid:connect_signal('button::press', function()
		cwid.bg = beautiful.widget_press
	end)

	-- Mouse releases the widget.

	cwid:connect_signal('button::release', function()
		cwid.bg = beautiful.widget_release
	end)

	return cwid
end
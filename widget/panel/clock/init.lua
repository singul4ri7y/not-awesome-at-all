local clock = wibox.widget {
	{
		{
			widget  = wibox.widget.textclock,
			format  = '%I',
			font    = default_font .. 'Bold 11',
			refresh = 5,
			valign  = 'center',
			align   = 'center'
		},

		{
			widget  = wibox.widget.textclock,
			format  = '%M',
			refresh = 5,
			font    = default_font .. 'Medium 11',
			valign  = 'center',
			align   = 'center'
		},

		layout  = wibox.layout.fixed.vertical
	},

	widget = wibox.container.margin,
	margins = { top = dpi(10), bottom = dpi(10) }
}

local tooltip = awful.tooltip {
	mode           = 'outside',
	align          = 'right',
	delay_show     = 0.5,
	timer_function = function() 
		return os.date('Today is %A, %d %b %Y GMT %z (UTC %Z)\nCurrent time %I:%M:%S (%p)')
	end
}

tooltip:add_to_object(clock)

return clock
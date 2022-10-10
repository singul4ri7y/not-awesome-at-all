return function()
	return {
		id 					= 'slider_widget',
		bar_shape           = gears.shape.rounded_rect,
		bar_height          = dpi(2),
		bar_color           = '#FFFFFF20',
		bar_active_color	= '#F2F2F2EE',
		handle_color        = '#FFFFFF',
		handle_shape        = gears.shape.circle,
		handle_width        = dpi(15),
		handle_border_color = '#00000012',
		handle_border_width = dpi(1),
		maximum				= 100,
		value               = 100,
		widget              = wibox.widget.slider,
	}
end
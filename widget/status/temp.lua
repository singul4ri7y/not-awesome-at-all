local temp_arc = require('widget.style.arch-chart')()

temp_arc.tooltip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

awesome.connect_signal('hardware::temp', function(value) 
	temp_arc.value = value

	temp_arc.tooltip:set_text('Current CPU temperature : ' .. value .. '° C')
end)

return temp_arc
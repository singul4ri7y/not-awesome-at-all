local cpu_arc = require('widget.style.arch-chart')()

cpu_arc.tooltip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

awesome.connect_signal('hardware::cpu', function(value) 
	cpu_arc.value = value

	cpu_arc.tooltip:set_text('Current CPU usage : ' .. value .. '%')
end)

return cpu_arc
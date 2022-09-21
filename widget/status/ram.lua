local ram_arc = require('widget.style.arch-chart')()

ram_arc.tooltip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

awesome.connect_signal('hardware::ram', function(used, total) 
	local perc    = (used / total) * 100

	ram_arc.value = perc

	ram_arc.tooltip:set_text('Current RAM usage ' .. string.format('%.2f/%.2f GB (%.0f%%)', used / 1024, total / 1024, perc))
end)

return ram_arc
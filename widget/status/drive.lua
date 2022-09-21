local drive_arc = require('widget.style.arch-chart')()

drive_arc.tooltip = awful.tooltip {
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

awesome.connect_signal('hardware::drive', function(used, total) 
	local perc = (used / total) * 100

	drive_arc.value = perc

	drive_arc.tooltip:set_text('Current drive usage (/) ' .. string.format('%.2f/%.2f GB (%.0f%%)', used, total, perc))
end)

return drive_arc
local ram_arc = require('widget.style.arch-chart')()

awesome.connect_signal('hardware::ram', function(usage, total) 
	ram_arc.value = (usage / total) * 100
end)

return ram_arc
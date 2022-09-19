local cpu_arc = require('widget.style.arch-chart')()

awesome.connect_signal('hardware::cpu', function(value) 
	cpu_arc.value = value
end)

return cpu_arc
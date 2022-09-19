local temp_arc = require('widget.style.arch-chart')()

awesome.connect_signal('hardware::temp', function(value) 
	temp_arc.value = value
end)

return temp_arc
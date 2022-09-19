local cpu_interval  = 5
local ram_interval  = 10
local temp_interval = 10

-- Periodically monitor hardware usage.

-- CPU Usage.

awful.widget.watch([[ zsh -c "vmstat 1 2 | tail -1 | awk '{ printf \"%d\", $15 }'" ]], cpu_interval, function(_, stdout)
	local cpu_idle = stdout:gsub('^%s*(.-)%s*$', '%1')

    awesome.emit_signal('hardware::cpu', 100 - tonumber(cpu_idle))
end)

-- RAM Usage.

awful.widget.watch([[ zsh -c "free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'" ]], ram_interval, function(_, stdout)
	local available = stdout:match('(.*)@@')
    local total     = stdout:match('@@(.*)@')
    local used      = tonumber(total) - tonumber(available)

    awesome.emit_signal('hardware::ram', used, total)
end)

-- CPU Temperature.

awful.widget.watch("sensors | grep Package | awk '{print $4}' | cut -c 2-3", temp_interval, function(_, stdout)
    awesome.emit_signal('hardware::temp', stdout)
end)
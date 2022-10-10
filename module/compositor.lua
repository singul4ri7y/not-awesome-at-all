local comp_status = false

awesome.connect_signal('compositor::init', function(switch)
	local file = io.open(config_dir .. 'module/data/compositor')

	assert(file)

	local data = file:read('*a')

	if data:find('true') then
		comp_status = true

		switch:on()

		awful.spawn.with_shell(config_dir .. 'config/user/assets/compositor.sh')
	end
end)

awesome.connect_signal('compositor::toggle', function(switch)
	if comp_status then
		comp_status = false

		switch:off()

		awful.spawn.with_shell('echo "false" > ' .. config_dir .. 'module/data/compositor')
		awful.spawn.with_shell('killall picom')
	else
		comp_status = true

		switch:on()

		awful.spawn.with_shell('echo "true" > ' .. config_dir .. 'module/data/compositor')
		awful.spawn.with_shell(config_dir .. 'config/user/assets/compositor.sh')
	end
end)
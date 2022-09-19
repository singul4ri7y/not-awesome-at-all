local caffeine_status = false

awesome.connect_signal('caffeine::init', function()
	local file = io.open(config_dir .. 'module/data/caffeine')

	assert(file)

	local data = file:read('*a')

	if data:find('true') then
		caffeine_status = true

		awful.spawn.with_shell('pgrep -u $USER -x xidlehook && killall -w -q xidlehook; caffeine')
	end
end)

awesome.connect_signal('caffeine::update', function(switch)
	if caffeine_status then
		switch:on()
	else switch:off() end
end)

awesome.connect_signal('caffeine::toggle', function(switch)
	if caffeine_status then
		caffeine_status = false

		switch:off()

		awful.spawn.with_shell('echo "false" > ' .. config_dir .. 'module/data/caffeine')
		awful.spawn.with_shell('pgrep -u $USER -x caffeine && killall -w -q caffeine; ' .. config_dir .. 'config/user/assets/screen-idle.sh')
	else
		caffeine_status = true

		switch:on()

		awful.spawn.with_shell('echo "true" > ' .. config_dir .. 'module/data/caffeine')
		awful.spawn.with_shell('pgrep -u $USER -x xidlehook && killall -w -q xidlehook; caffeine')
	end
end)
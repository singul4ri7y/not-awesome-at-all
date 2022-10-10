local caffeine_status = false

awesome.connect_signal('caffeine::init', function(switch)
	local file = io.open(config_dir .. 'module/data/caffeine')

	assert(file)

	local data = file:read('*a')

	if data:find('true') then
		caffeine_status = true

		switch:on()

		awful.spawn.with_shell('pgrep -u $USER -x xidlehook && killall -w -q xidlehook; pgrep -u $USER -x caffeine || caffeine; xset s off')
	end
end)

awesome.connect_signal('caffeine::toggle', function(switch)
	if caffeine_status then
		caffeine_status = false

		switch:off()

		awful.spawn.with_shell('echo "false" > ' .. config_dir .. 'module/data/caffeine')
		awful.spawn.with_shell('pgrep -u $USER -x caffeine && killall -w -q caffeine; ' .. config_dir .. 'config/user/assets/screen-idle.sh; xset s on')
	else
		caffeine_status = true

		switch:on()

		awful.spawn.with_shell('echo "true" > ' .. config_dir .. 'module/data/caffeine')
		awful.spawn.with_shell('pgrep -u $USER -x xidlehook && killall -w -q xidlehook; caffeine')
	end
end)
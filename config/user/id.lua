local id = {
	username = os.getenv('USER'),
	profile  = config_dir .. 'config/user/assets/profile.jpg'
}

-- Get the user full name.

local file = io.popen('getent passwd "' .. id.username .. '" | cut -d ":" -f 5 | cut -d "," -f 1')

id.fullname = file:read('*a'):gsub('\n$', '')

file:close()

return id
local apps  = require('config.user.apps')
local icons = require('theme.icons')

-- All those different tags/workspaces.

local tags = {
	{
		type = 'internet',
		icon = icons.brave,
		default_app = apps.browser,
		gap = beautiful.useless_gap
	},

	{
		type = 'code',
		icon = icons.code,
		default_app = apps.dev,
		gap = beautiful.useless_gap
	},

	{
		type = 'social',
		icon = icons.social,
		default_app = apps.social,
		gap = beautiful.useless_gap
	},

	{
		type = 'games',
		icon = icons.game,
		default_app = apps.game,
		gap = beautiful.no_gap,
		layout = awful.layout.suit.max.fullscreen
	},

	{
		type = 'files',
		icon = icons.folder,
		default_app = apps.files,
		gap = beautiful.useless_gap,
	},

	{
		type = 'sandbox',
		icon = icons.sandbox,
		default_app = apps.sandbox,
		layout = awful.layout.suit.max.fullscreen,
		gap = beautiful.no_gap
	},

	{
		type = 'multimedia',
		icon = icons.media,
		default_app = apps.media,
		layout = awful.layout.suit.max,
		gap = beautiful.no_gap
	},

	-- {
	-- 	type = 'graphics',
	-- 	icon = icons.graphics,
	-- 	default_app = apps.default.graphics,
	-- 	layout = awful.layout.suit.max,
	-- 	gap = beautiful.useless_gap
	-- },

	{
		type = 'experiments',
		icon = icons.lab,
		default_app = apps.terminal,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.floating
	}
}

-- Table of default layouts going to be used.

tag.connect_signal('request::default_layouts', function()
	awful.layout.append_default_layouts {
		awful.layout.suit.spiral,
		awful.layout.suit.floating,
		awful.layout.suit.max,
		awful.layout.suit.max.fullscreen
	}
end)

-- Tags will apply for each screen.

screen.connect_signal('request::desktop_decoration', function(scr) 
	for i, tag in pairs(tags) do
		awful.tag.add(i, {
			icon              = tag.icon,
			icon_only         = true,
			layout            = tag.layout or awful.layout.suit.spiral,
			gap_single_client = true,
			default_app       = tag.default_app,
			gap               = tag.gap,
			screen            = scr,
			selected          = i == 1
		})
	end
end)

-- TODO: Code will be added in the future.

local function update_gap_and_shape(tag) 
	-- Get the current tag layout.

	local layout = awful.tag.getproperty(tag, 'layout')

	-- Use no gap between clients in 'max' and 'fullscreen' layout.

	if layout == awful.layout.suit.max or layout == awful.layout.suit.max.fullscreen then
		tag.gap = beautiful.no_gap
	else tag.gap = beautiful.useless_gap end
end

-- Change client's gap and shape on layout change.

tag.connect_signal('property::layout', update_gap_and_shape)

-- Change client's gap and shape when a client is moved
-- to a different tag.

tag.connect_signal('tagged', update_gap_and_shape)

-- Focus on urgent clients.

local function urgent_clients(c) 
	return awful.rules.match(c, { urgent  = true })
end

awful.tag.attached_connect_signal(s, 'property::selected', function(c)
	for c in awful.client.iterate(urgent_clients) do
		-- If the client is in the current active tag, then
		-- focus on it.

		if c.first_tag == _G.mouse.screen.selected_tag then
			c:emit_signal('request::activate')
			c:raise()
		end
	end
end)
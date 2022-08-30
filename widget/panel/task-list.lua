local clickable_widget = require('widget.style.clickable-widget')
local icons            = require('theme.icons')

-- Below codes are copied from /usr/share/awesome/lib/awful/widget/common.lua
-- and edited.

local capi   = { button = button }
local base   = require('wibox.widget.base')
local gdebug = require('gears.debug')

local function create_buttons(buttons, object)
	local is_formatted = buttons and buttons[1] and (
		type(buttons[1]) == "button" or buttons[1]._is_capi_button) or false

	if buttons then
		local btns = {}
		for _, src in ipairs(buttons) do
			--TODO v6 Remove this legacy overhead.
			
			for _, b in ipairs(is_formatted and { src } or src) do
				-- Create a proxy button object: it will receive the real
				-- press and release events, and will propagate them to the
				-- button object the user provided, but with the object as
				-- argument.

				local btn = capi.button { modifiers = b.modifiers, button = b.button }

				btn:connect_signal('press', function() b:emit_signal('press', object) end)
				btn:connect_signal('release', function() b:emit_signal('release', object) end)

				btns[#btns + 1] = btn
			end
		end

		return btns
	end
end

local function custom_template(args)
	local l = base.make_widget_from_value(args.widget_template)

	-- The template system requires being able to get children elements by ids.
	-- This is not optimal, but for now there is no way around it.

	assert(l.get_children_by_id, 'The given widget template did not result in a' ..
		'layout with a "get_children_by_id" method')

	return {
		ib              = l:get_children_by_id('icon_role')[1],
		tb              = l:get_children_by_id('text_role')[1],
		cb              = l:get_children_by_id('close_button_role')[1],
		bgb             = l:get_children_by_id('background_role')[1],
		tbm             = l:get_children_by_id('text_margin_role')[1],
		ibm             = l:get_children_by_id('icon_margin_role')[1],
		cbm             = l:get_children_by_id('close_button_margin_role')[1],
		primary         = l,
		update_callback = l.update_callback,
		create_callback = l.create_callback,
	}
end

local usable_template = {
	id = 'background_role',
	border_strategy = 'inner',
	stretch = false,
	widget = wibox.container.background,
	
	{
		widget = wibox.layout.fixed.horizontal,
		fill_space = true,
		{
			id = 'icon_margin_role',
			widget = wibox.container.margin,
			margins = dpi(10),
			{
				id = 'icon_role',
				widget = wibox.widget.imagebox,
				left = dpi(4),
			},
		},
		{
			id = 'text_margin_role',
			widget = wibox.container.margin,
			left = dpi(4),
			right = dpi(4),
			{
				id = 'text_role',
				widget = wibox.widget.textbox,
			},
		},
		{
			id = 'clickable_close_button_margin_role',
			widget = wibox.container.margin,
			margins = dpi(13),
			{
				id = 'clickable_close_button_role',
				widget = clickable_widget,

				{
					id = 'close_button_margin_role',
					widget = wibox.container.margin,
					shape = gears.shape.circle,
					margins = dpi(5),
					{
						id = 'close_button_role',
						image = icons.close,
						widget = wibox.widget.imagebox
					}
				}
			}
		}
	}
}

local function default_template()
	return custom_template {
		widget_template = usable_template
	}
end

local maximized_indicator = '+'
local sticky_indicator    = '▪'
local above_indicator     = '▴'
local below_indicator     = '▾'
local ontop_indicator     = '^'
local floating_indicator  = '✈'
local max_horiz_indicator = '⬌'
local max_vert_indicator  = '⬍'
local minimized_indicator = '_'

local function list_update(w, buttons, label, data, objects, args)
	-- update the widgets, creating them if needed.

	w:reset()
	
	for i, o in ipairs(objects) do
		local cache = data[o]

		-- Allow the buttons to be replaced.
		
		if cache and cache._buttons ~= buttons then
			cache = nil
		end

		if not cache then
			cache = (args and args.widget_template) and
				custom_template(args) or default_template()

			cache.primary.buttons = { create_buttons(buttons, o) }

			if cache.create_callback then
				cache.create_callback(cache.primary, o, i, objects)
			end

			if args and args.create_callback then
				args.create_callback(cache.primary, o, i, objects)
			end

			cache.tt = awful.tooltip {
				objects    = { tb },
				mode       = 'outside',
				align      = 'bottom',
				delay_show = 0.5
			}

			cache._buttons = buttons

			data[o] = cache
		elseif cache.update_callback then
			cache.update_callback(cache.primary, o, i, objects)
		end

		local text, bg, bg_image, icon, item_args = label(o, cache.tb)
		item_args = item_args or {}

		-- Add close button action.

		cache.cbm:buttons(gears.table.join(
			awful.button({}, 1, nil, function() 
				o:kill()
			end)
		))

		local base_text = text:match('>(.-)<'):gsub('&[^;]+;', '')

		local window_indicators = ''

		if o.sticky then window_indicators = sticky_indicator .. window_indicators end

		if o.ontop then window_indicators = ontop_indicator .. window_indicators
		elseif o.above then window_indicators = above_indicator .. window_indicators
		elseif o.below then window_indicators = below_indicator .. window_indicators end

		if o.maximized then
			window_indicators = maximized_indicator .. window_indicators
		else
			if o.maximized_horizontal then window_indicators = max_horiz_indicator .. window_indicators end
			if o.maximized_vertical then window_indicators = max_vert_indicator .. window_indicators end
			if o.floating then window_indicators = floating_indicator .. window_indicators end
		end

		if o.minimized then window_indicators = minimized_indicator .. window_indicators end

		base_text = (window_indicators == '' and '' or '(' .. window_indicators .. ') ') .. base_text

		if utf8.len(base_text) > 25 then
			text = text:gsub('>(.-)<', '>' .. base_text:sub(1, utf8.offset(base_text, 23) - 1) .. '...<')
			cache.tt:set_text(base_text)
			cache.tt:add_to_object(cache.bgb)
		else
			text = text:gsub('>(.-)<', '>' .. base_text .. '<')
			cache.tt:remove_from_object(cache.bgb)
		end

		-- The text might be invalid, so use pcall.
		if cache.tbm and (text == nil or text == '') then
			cache.tbm:set_margins(0)
		elseif cache.tb then
			if not cache.tb:set_markup_silently(text) then
				cache.tb:set_markup('<i>&lt;Invalid text&gt;</i>')
			end
		end

		if cache.bgb then
			cache.bgb:set_bg(bg)

			-- TODO v5 remove this if, it existed only for a removed and
			-- undocumented API.

			if type(bg_image) ~= 'function' then
				cache.bgb:set_bgimage(bg_image)
			else
				gdebug.deprecate('If you read this, you used an undocumented API'..
					' which has been replaced by the new awful.widget.common '..
					'templating system, please migrate now. This feature is '..
					'already staged for removal', {
					deprecated_in = 4
				})
			end

			cache.bgb.shape        = item_args.shape
			cache.bgb.border_width = item_args.shape_border_width
			cache.bgb.border_color = item_args.shape_border_color

		end

		if cache.ib and icon then
			cache.ib:set_image(icon)
		elseif cache.ibm then
			cache.ibm:set_margins(0)
		end

		if item_args.icon_size and cache.ib then
			cache.ib.forced_height = item_args.icon_size
			cache.ib.forced_width  = item_args.icon_size
		elseif cache.ib then
			cache.ib.forced_height = nil
			cache.ib.forced_width  = nil
		end

		w:add(cache.primary)
	end
end

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			-- I don't understand any of dis.

			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end

			-- This will also un-minimize
			-- the client, if needed.

			c:emit_signal('request::activate')
			c:raise()
		end
	end),

	awful.button({}, 2, function(c)
		c:kill()
	end),

	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),

	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

return function(scr)
	return awful.widget.tasklist {
		screen          = scr,
		filter          = awful.widget.tasklist.filter.currenttags,
		buttons         = tasklist_buttons,
		update_function = list_update,
		widget_template = usable_template
	}
end
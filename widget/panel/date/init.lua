return function(scr) 
    local date = wibox.widget.textclock('<span font= "' .. default_font .. 'Bold 9' .. '">%a %b %d, %Y (%p)</span>', 60)

    -- Attach a calendar to the textclock.

    local calendar = awful.widget.calendar_popup.month {
        screen       = scr,
        start_sunday = true,
        week_numbers = true
    }

    -- Now attach the calendar to the date widget.

    calendar:attach(date)

    return {
        date,
        widget = wibox.container.margin,
        right  = dpi(15)
    }
end
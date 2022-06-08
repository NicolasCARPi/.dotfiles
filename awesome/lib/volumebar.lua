-------------------------------------------------
-- Volume Bar Widget for Awesome Window Manager
-- Shows the current volume level
-- More details can be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volumebar-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-- modified by NicolasCARPi
-------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- local request_command = "amixer get Master"
local request_command = "pamixer --get-volume"

local bar_color = beautiful.fg_normal
local mute_color = "#ff0000"
local background_color = "#3a3a3a"

local volumebar = wibox.widget {
    max_value = 100,
    forced_width = 50,
    paddings = 0,
    border_width = 0.5,
    color = bar_color,
    background_color = background_color,
    shape = gears.shape.bar,
    clip = true,
    margins       = {
        top = 9,
        bottom = 9,
    },
    widget = wibox.widget.progressbar
}

local update_graphic = function(widget, stdout, _, _, _)
    -- local mute = string.match(stdout, "%[(o%D%D?)%]")
    -- local mute = spawn.easy_async("pamixer --get-mute", function() end)
    -- local volume = string.match(stdout, "(%d?%d?%d)%%")
    -- volume = tonumber(string.format("% 3d", volume))
    spawn.easy_async("pamixer --get-volume", function(stdout)
        widget.value = tonumber(stdout)
    end)

    -- widget.value = volume / 100;
    -- if mute == "false" then
    --     widget.color = mute_color
    --     widget.value = volume;
    -- else
    --     widget.color = bar_color
    --     widget.value = volume;
    -- end
end

volumebar:connect_signal("button::press", function(_,_,_,button)
    -- scroll up
    -- if (button == 4)     then awful.spawn("amixer set Master 2dB+", false)
    if (button == 4)     then spawn.easy_async("pamixer --increase 5", function() end)
    -- scroll down
    -- elseif (button == 5) then awful.spawn("amixer set Master 2dB-", false)
    elseif (button == 5) then spawn.easy_async("pamixer --decrease 5", function() end)
    -- left click
    elseif (button == 1) then spawn.easy_async("mpc toggle", function() end)
    -- right click
    elseif (button == 3) then spawn.easy_async("mpc stop", function() end)
    end

    spawn.easy_async(update_graphic(volumebar, stdout, stderr, exitreason, exitcode), function() end)
    --spawn.easy_async(request_command, function(stdout, stderr, exitreason, exitcode)
    --    update_graphic(volumebar, stdout, stderr, exitreason, exitcode)
    --end)
end)

watch(request_command, 1, update_graphic, volumebar)

return volumebar

-- awesomusic.lua | an mpd widget for awesomewm
-- by NicolasCARPi
-- https://github.com/NicolasCARPi/.dotfiles
-- requires "mpc" and "amixer"

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")

local awesomusic = wibox.widget {
    paddings = 250,
    border_width = 5,
    widget = wibox.widget.textbox
}

-- for some reason the | head -n 1 is not working so we need to split the stdout
function awesomusic:split(input_str, sep)
    if sep == nil then
        sep = "\n"
    end
    local t={}
    local i=0
    for str in string.gmatch(input_str, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- display current song
function awesomusic:show_song()
    watch("mpc status", 2,
        function(widget, stdout, stderr, exitreason, exitcode)
            local rand_icon = ""
            local icon = "▶ "
            local out = awesomusic:split(stdout)

            if out[0]:match("^volume") then
                -- nothing is playing
                widget:set_text("")
                return false
            end
            if out[2]:match("random: on") then
                rand_icon = " ⚡"
            end

            if out[1]:match("paused") then
                icon = "⌷⌷ "
            end
            -- status is first line
            local status = out[0]

            out = icon .. status .. rand_icon .. " "

            widget:set_text(out)
        end,
        awesomusic
    )
end

-- toggle music (play/pause)
function awesomusic:toggle()
    os.execute("mpc toggle")
end

-- previous song
function awesomusic:prev()
    os.execute("mpc prev")
end

-- toggle random
function awesomusic:random()
    os.execute("mpc random")
end

-- skip to next song
function awesomusic:skip()
    os.execute("mpc next")
end

-- set volume (sign should be + or -)
function awesomusic:vol(sign)
    os.execute("pactl set-sink-volume alsa_output.pci-0000_2f__00.4.analog-stereo " .. sign .. "3%")
end

-- init
awesomusic:show_song()

-- bind buttons, left click to toggle, right click to skip
awesomusic:connect_signal("button::press", function(_, _, _, button)
    -- left click
    if (button == 1) then awesomusic:toggle() end
    -- right click
    if (button == 3) then awesomusic:skip() end
    -- middle click
    --if (button == 2) then awesomusic:prev() end
    if (button == 2) then awesomusic:random() end
    -- scroll up
    if (button == 4) then awesomusic:vol("+") end
    -- scroll down
    if (button == 5) then awesomusic:vol("-") end
end)

return awesomusic

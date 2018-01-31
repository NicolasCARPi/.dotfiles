-- awesomusic.lua | an mpd widget for awesomewm
-- by NicolasCARPi
-- requires "mpc" and "amixer"

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")

local awesomusic = wibox.widget.textbox()

--rand_icon = wibox.widget.imagebox()
--rand_icon:set_image(confdir .. "/lib/pacman.png")

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
            --local rand_icon = ""
            local rand_txt = ""
            out = awesomusic:split(stdout)
            if out[0]:match("^volume") then
                -- nothing is playing
                widget:set_text("")
                return false
            end
            if out[2]:match("random: on") then
                rand_txt = " (Z)"
            end
            -- status is first line
            status = out[0]

            -- now get volume
            --local cmd = "amixer get 'PCM'"
            --local f = assert(io.popen(cmd))
            --local amixer_out = assert(f:read('*a'))
            --local amixer_out_split = awesomusic:split(amixer_out)
            --local line_split = awesomusic:split(amixer_get[5], " ")
            --local vol = line_split[4]
            --local vol = "A"
            --out = status .. " | " .. vol .. " | "
            out = status .. rand_txt .. " "
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
    os.execute("amixer -q set 'PCM' 2dB" .. sign)
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

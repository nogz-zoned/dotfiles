--[[
                                      
     Zoned Awesome WM config 2.0 
     github.com/copycat-killer        
                                      
--]]

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
local vicious   = require("vicious")
local ror 	= require("aweror")
local eminent   = require("eminent")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("urxvtd")
run_once("unclutter -root")
run_once("compton -b &")
run_once("bitlbee -D &")
-- }}}

-- {{{ Variable definitions

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/zoned/theme.lua")

-- common
key        = "Mod4"
altkey     = "Mod1"
terminal   = "urxvt" or "xterm"
editor     = os.getenv("EDITOR") or "vim" or "nano"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser    = "chromium"
browser2   = "dwb"
gui_editor = "gvim"
graphics   = "gimp"
mail       = terminal .. " -e mutt "
musicplr   = terminal .. " -g 130x34-320+16 -e ncmpcpp "
htop 	   = terminal .. " -e htop "

local layouts = {
    lain.layout.uselesspiral,
    lain.layout.centerwork,
    lain.layout.uselesstile,
    lain.layout.uselesstile.left,
    lain.layout.uselesstile.top,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
tags = {
   names = { "www", "games", "term", "media", "img", "chat", "vbox", "extra" },
   layout = { layouts[1], layouts[3], layouts[4], layouts[4], layouts[6], layouts[5], layouts[6], layouts[1] }
}
for s = 1, screen.count() do
-- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
   awful.tag.seticon (beautiful.browser_icon, tags [s] [1])
   awful.tag.seticon (beautiful.game_icon, tags [s] [2])
   awful.tag.seticon (beautiful.shell_icon, tags [s] [3])
   awful.tag.seticon (beautiful.media_icon, tags [s] [4])
   awful.tag.seticon (beautiful.gimp_icon, tags [s] [5])
   awful.tag.seticon (beautiful.chat_icon, tags [s] [6])
   awful.tag.seticon (beautiful.vbox_icon, tags [s] [7])
   awful.tag.seticon (beautiful.other_icon, tags [s] [8])
end
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Freedesktop Menu
mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
                              theme = { height = 16, width = 130 }})
-- }}}

-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
--mytextclock = awful.widget.textclock(markup("#d3d3d3", "%A %d %B ") .. markup("#d3d3d3", ">") .. markup("#d3d3d3", " %H:%M "))
mytextclock = lain.widgets.abase({
    timeout  = 60,
    cmd      = "date +'%A %d %B %R'",
    settings = function()
        local t_output = ""
        local o_it = string.gmatch(output, "%S+")

        for i=1,3 do t_output = t_output .. " " .. o_it(i) end

        widget:set_markup(markup("#d3d3d3", t_output) .. markup("#d3d3d3", " ") .. markup("#d3d3d3", o_it(1)) .. " ")
    end
})

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- Weather
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
myweather = lain.widgets.weather({
    city_id = 4791259, -- placeholder
    units = "imperial",
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup("#d3d3d3", descr .. ", " .. units .. "°F "))
    end
})

-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#d3d3d3", fs_now.used .. "% "))
    end
})

-- Mail IMAP check
-- commented because it needs to be set before use
mailicon = wibox.widget.imagebox()
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "imap.google.com",
    mail     = "lookinoji@gmail.com",
    password = "hi90AS#$",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup("#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            mailicon:set_image(nil)
        end
    end
})

-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#d3d3d3", cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#d3d3d3", coretemp_now .. "°C "))
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            perc = "AC "
        else
            perc = bat_now.perc .. "% "
        end
        widget:set_text(perc)
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
	settings = function()
		if volume_now.status == "off" then
		volicon:set_image(beautiful.widget_vol_mute)
		elseif tonumber(volume_now.level) == 0 then
		volicon:set_image(beautiful.widget_vol_no)
		elseif tonumber(volume_now.level) <= 50 then
		volicon:set_image(beautiful.widget_vol_low)
		else
		volicon:set_image(beautiful.widget_vol)
		end

		widget:set_markup(markup("#d3d3d3", volume_now.level .. "% "))
	end
})

-- Net
netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"
netupinfo = lain.widgets.net({
    settings = function()
        if iface ~= "network off" and
           string.match(myweather._layout.text, "N/A")
        then
            myweather.update()
        end

        widget:set_markup(markup("#d3d3d3", net_now.sent .. " "))
        netdowninfo:set_markup(markup("#d3d3d3", net_now.received .. " "))
    end
})

-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#d3d3d3", mem_now.used .. "M "))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
	    music_dir = "~/media/music",
	    title = "Now Playing",
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = " ".. mpd_now.artist .. " - "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#e54c62", artist) .. markup("#d3d3d3", title))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")

-- }}}

-- Uptime
uptimeicon = wibox.widget.imagebox(beautiful.widget_uptime)
uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget, vicious.widgets.uptime, 
	function (widget, args)
		return string.format("<span color='#d3d3d3'>%2dd %02d:%02d </span>",args[1], args[2], args[3])
	end, 1)
-- }}}

-- Package Update
pkgicon = wibox.widget.imagebox(beautiful.widget_pkg)
pkgwidget = wibox.widget.textbox()
vicious.register(pkgwidget, vicious.widgets.pkg, function (widget, args )
		if args [1] == 0 then return "<span color='#d3d3d3'>Up to date!</span>"
		else return "<span color='#d3d3d3'>" .. args[1] .. " new pkg(s) </span>"
		end
	end,3600,"Arch")

mylauncher = awful.widget.launcher({ image = beautiful.arch_icon, menu = mymainmenu })
-- }}}

-- OS
oswidget = wibox.widget.textbox()
vicious.register(oswidget, vicious.widgets.os, function (widgets, args) 
	return args[2]
end,3600)
--}}}

-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ key }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ key }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()


    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })
    --border_width = 0, height =  20 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(mpdicon)
    left_layout:add(mpdwidget)

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(mailicon)
    right_layout:add(mailwidget)
    right_layout:add(netdownicon)
    right_layout:add(netdowninfo)
    right_layout:add(netupicon)
    right_layout:add(netupinfo)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(tempicon)
    right_layout:add(tempwidget)
    right_layout:add(fsicon)
    right_layout:add(fswidget)
    right_layout:add(weathericon)
    right_layout:add(myweather)
    --right_layout:add(baticon)
    --right_layout:add(batwidget)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    --layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create the bottom wibox
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
    --mybottomwibox[s].visible = false

    -- Widgets that are aligned to the bottom left
    bottom_left_layout = wibox.layout.fixed.horizontal()

    -- Widgets that are aligned to the bottom right
    bottom_right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then bottom_right_layout:add(wibox.widget.systray()) end
    bottom_right_layout:add(spacer)
    bottom_right_layout:add(pkgicon)
    bottom_right_layout:add(pkgwidget)
    bottom_right_layout:add(uptimeicon)
    bottom_right_layout:add(uptimewidget)
    bottom_right_layout:add(oswidget)
    bottom_right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(globalkeys,
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    -- Tag browsing
    awful.key({ key }, "Left",   awful.tag.viewprev       ),
    awful.key({ key }, "Right",  awful.tag.viewnext       ),
    awful.key({ key }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    -- Default client focus
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ key }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ key }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ key }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ key }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ key }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ key }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Layout manipulation
    awful.key({ key, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ key, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ key, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ key, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ key,           }, "u", awful.client.urgent.jumpto),
    awful.key({ key,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ key, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ key, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ key, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ key, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ key,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ key, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ key, "Control" }, "n",      awful.client.restore),

    -- Standard program
    awful.key({ key,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ key, "Control" }, "r",      awesome.restart),
    awful.key({ key, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    awful.key({ key,	          }, "z",      function () drop(terminal) end),

    -- Widgets popups
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),
    awful.key({ altkey,           }, "w",      function () myweather.show(7) end),

    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute(string.format("amixer set %s toggle", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volumewidget.channel))
            volumewidget.update()
        end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
            mpdwidget.update()
        end),

    -- Copy to clipboard
    awful.key({ key }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

    -- User programs
    --awful.key({ key }, "q", function () awful.util.spawn(browser) end),
    --awful.key({ key }, "i", function () awful.util.spawn(browser2) end),
    --awful.key({ key }, "s", function () awful.util.spawn(gui_editor) end),
    --awful.key({ key }, "g", function () awful.util.spawn(graphics) end),
    --awful.key({ key }, "y", function () awful.util.spawn(musicplr) end),

    -- Prompt
    awful.key({ key }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ key }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
     
     ror.genkeys(key)
)

clientkeys = awful.util.table.join(
    awful.key({ key,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ key, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ key, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ key, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ key,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ key,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ key,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ key,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ key }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ key, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ key, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ key, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ key }, 1, awful.mouse.client.move),
    awful.button({ key }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } },
    { rule = { class = "URxvt" },
          properties = { opacity = 0.99 } },

    { rule = { class = "MPlayer" },
          properties = { floating = true } },

   { rule = { class = "Dwb" },
   	  properties = { tag = tags[1][1] } },

    { rule = { class = "Iron" },
          properties = { tag = tags[1][1] } },

    { rule = { instance = "plugin-container" },
          properties = { tag = tags[1][1] } },

    { rule = { class = "Gimp" },
     	  properties = { tag = tags[1][5] } },

    { rule = { class = "Steam" },
          properties = { tag = tags[1][2]} },

    { rule = { class = "VirtualBox" },
          properties = { tag = tags[2][7]} },

    { rule = { class = "htop" },
          properties = { tag = tags[1][6]} },

    { rule = { class = "mpv" },
          properties = { tag = tags[2][4]} },
    
    { rule = { class = "VirtualBox" },
    	  properties = { tag = tags[1][7]} },

    --{ rule = { class = "chromium" },
    --      properties = { tag = tags[2][1]} },
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
local sloppyfocus_last = {c=nil}
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             -- Skip focusing the client if the mouse wasn't moved.
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
             end
         end
     end)

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- the title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                -- No borders with only one humanly visible client
                if layout == "max" then
                    c.border_width = 0
                elseif awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then
                    clients[1].border_width = 0
                    if layout ~= "max" then
                        awful.client.moveresize(0, 0, 2, 0, clients[1])
                    end
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}

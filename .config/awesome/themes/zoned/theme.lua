
--[[
                                   
     Dremora Awesome WM dir 2.0 
     github.com/copycat-killer     
                                   
--]]

theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/.config/awesome/themes/zoned"
theme.wallpaper                     = theme.dir .. "/calvin.png"

theme.font                          = "Hack 9"
theme.taglist_font                  = "Hack 10"
theme.fg_normal                     = "#747474"
theme.fg_focus                      = "#DDDCFF"
theme.bg_normal                     = "#121212"
theme.bg_focus                      = "#121212"
theme.fg_urgent                     = "#CC9393"
theme.bg_urgent                     = "#2A1F1E"
theme.border_width                  = "2"
theme.border_normal                 = "#121212"
theme.border_focus                  = "#292929"
theme.titlebar_bg_focus             = "#292929"

theme.taglist_fg_focus              = "#dddcff"
theme.taglist_bg_focus              = "#121212"
theme.menu_height                   = "16"
theme.menu_width                    = "140"

theme.browser_icon 		    = theme.dir .. "/icons/Globe-256.png"
theme.game_icon 		    = theme.dir .. "/icons/Joystick-256.png"
theme.shell_icon 		    = theme.dir .. "/icons/Shell-24.png"
theme.media_icon 		    = theme.dir .. "/icons/Media-Play-01-256.png"
theme.gimp_icon 		    = theme.dir .. "/icons/Camera-01-256.png"
theme.chat_icon 		    = theme.dir .. "/icons/Messages-256.png"
theme.vbox_icon 		    = theme.dir .. "/icons/Shape-Cube-256.png"
theme.other_icon 		    = theme.dir .. "/icons/Shape-Star2-256.png"

theme.submenu_icon                  = theme.dir .. "/icons/submenu.png"
theme.widget_temp                   = theme.dir .. "/icons/Instrument-Thermometer-256.png"
theme.widget_uptime                 = theme.dir .. "/icons/Plug-256.png"
theme.widget_pkg 		    = theme.dir .. "/icons/Box-Add-256.png"
theme.widget_cpu                    = theme.dir .. "/icons/CPU-01-256.png"
theme.widget_weather                = theme.dir .. "/icons/Satellite-256.png"
theme.widget_fs                     = theme.dir .. "/icons/Disk-HDD-256.png"
theme.widget_mem                    = theme.dir .. "/icons/Computer-Desktop-256.png"
theme.widget_fs                     = theme.dir .. "/icons/Disk-HDD-256.png"
theme.widget_note                   = theme.dir .. "/icons/Headphone-01-256.png"
theme.widget_note_on                = theme.dir .. "/icons/Headphone-01-256.png"
theme.widget_netdown                = theme.dir .. "/icons/Arrowhead-01-256.png"
theme.widget_netup                  = theme.dir .. "/icons/Arrowhead-Down-01-256.png"
theme.widget_mail                   = theme.dir .. "/icons/mail.png"
theme.widget_batt                   = theme.dir .. "/icons/bat.png"
theme.widget_clock                  = theme.dir .. "/icons/Calendar-256.png"
theme.widget_vol                    = theme.dir .. "/icons/Volume-256.png"
theme.widget_vol_no 		    = theme.dir .. "/icons/Volume-No-256.png"
theme.widget_vol_low 	            = theme.dir .. "/icons/Volume-Low-256.png"
theme.widget_vol_mute 		    = theme.dir .. "/icons/Volume-Mute-256.png"

theme.taglist_squares_sel           = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = theme.dir .. "/icons/square_unsel.png"
theme.arrl_lr_pre                   = theme.dir .. "/icons/arrl_lr_pre.png"
theme.arrl_lr_post                  = theme.dir .. "/icons/arrl_lr_post.png"

theme.layout_tile                   = theme.dir .. "/icons/tile.png"
theme.layout_tilegaps               = theme.dir .. "/icons/tilegaps.png"
theme.layout_tileleft               = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.dir .. "/icons/dwindle.png"
theme.layout_max                    = theme.dir .. "/icons/max.png"
theme.layout_fullscreen             = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier              = theme.dir .. "/icons/magnifier.png"
theme.layout_floating               = theme.dir .. "/icons/floating.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- lain related
theme.useless_gap_width             = 10
theme.layout_termfair 		    = theme.dir .. "/icons/fairv.png"
theme.layout_uselesstile            = theme.dir .. "/icons/uselesstile.png"
theme.layout_centerwork 	    = theme.dir .. "/icons/centerworkw.png"
theme.layout_uselesstileleft        = theme.dir .. "/icons/uselesstileleft.png"
theme.layout_uselesstiletop         = theme.dir .. "/icons/uselesstiletop.png"

theme.arch_icon 		    = theme.dir .. "/icons/symbol.png"

return theme

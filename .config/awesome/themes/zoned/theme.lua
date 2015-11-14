--[[
                                   
     Dremora Awesome WM dir 2.0 
     github.com/copycat-killer     
                                   
--]]

theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/.config/awesome/themes/zoned"
theme.wallpaperdir 		    = os.getenv("HOME") .. "/.config/awesome/wallpaper"
theme.wallpaper                     = theme.wallpaperdir .. "/archos.png"

theme.font                          = "Hack 9"
theme.taglist_font                  = "Hack 10"
theme.fg_normal                     = "#ffffff"
theme.fg_focus                      = "#ffffff"
theme.bg_normal                     = "#2f343f"
theme.bg_focus                      = "#5294e2"
theme.fg_urgent                     = "#cc9393"
theme.bg_urgent                     = "#2a1f1e"
theme.border_width                  = "3"
theme.border_normal                 = "#414857"
theme.border_focus                  = "#2f343f"
theme.titlebar_bg_focus             = "#2f3f3f"

theme.taglist_fg_focus              = "#ffffff"
theme.taglist_bg_focus              = "#5294e2"
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

theme.taglist_squares_sel           = theme.dir .. "/icons/layout/square_sel.png"
theme.taglist_squares_unsel         = theme.dir .. "/icons/layout/square_unsel.png"
theme.arrl_lr_pre                   = theme.dir .. "/icons/layout/arrl_lr_pre.png"
theme.arrl_lr_post                  = theme.dir .. "/icons/layout/arrl_lr_post.png"

theme.layout_tile                   = theme.dir .. "/icons/layout/tile.png"
theme.layout_tilegaps               = theme.dir .. "/icons/layout/tilegaps.png"
theme.layout_tileleft               = theme.dir .. "/icons/layout/tileleft.png"
theme.layout_tilebottom             = theme.dir .. "/icons/layout/tilebottom.png"
theme.layout_tiletop                = theme.dir .. "/icons/layout/tiletop.png"
theme.layout_fairv                  = theme.dir .. "/icons/layout/fairv.png"
theme.layout_fairh                  = theme.dir .. "/icons/layout/fairh.png"
theme.layout_spiral                 = theme.dir .. "/icons/layout/spiral.png"
theme.layout_dwindle                = theme.dir .. "/icons/layout/dwindle.png"
theme.layout_max                    = theme.dir .. "/icons/layout/max.png"
theme.layout_fullscreen             = theme.dir .. "/icons/layout/fullscreen.png"
theme.layout_magnifier              = theme.dir .. "/icons/layout/magnifier.png"
theme.layout_floating               = theme.dir .. "/icons/layout/floating.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- lain related
theme.useless_gap_width             = 10
theme.layout_termfair 		    = theme.dir .. "/icons/layout/fairv.png"
theme.layout_uselesstile            = theme.dir .. "/icons/layout/uselesstile.png"
theme.layout_centerwork 	    = theme.dir .. "/icons/layout/centerworkw.png"
theme.layout_uselesstileleft        = theme.dir .. "/icons/layout/uselesstileleft.png"
theme.layout_uselesstiletop         = theme.dir .. "/icons/layout/uselesstiletop.png"
theme.layout_uselesspiral 	    = theme.dir .. "/icons/layout/spiral.png"

theme.arch_icon 		    = theme.dir .. "/icons/symbol.png"

return theme

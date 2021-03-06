-- ror.lua
-- This is the file goes in your ~/.config/awesome/ directory
-- It contains your table of 'run or raise' key bindings for aweror.lua
-- Table entry format: ["key"]={"function", "match string", "optional attribute to match"}
-- The "key" can include "Control-", "Shift-", and "Mod1-" modifiers (eg "Control-z")
-- The "key" will be bound as "modkey + key". (eg from above would end up as modkey+Control+z)
-- The "function" is what gets run if no matching client windows are found.
-- Usual attributes are "class","instance", or "name". If no attribute is given it defaults to "class".
-- The "match string"  will match substrings.  So "Firefox" will match "blah Firefox blah"  
-- Use xprop to get this info from a window.  WM_CLASS(STRING) gives you "instance", "class".
-- WM_NAME(STRING) gives you the name of the selected window (usually something like the web page title
-- for browsers, or the file name for emacs).

table5={
   ["e"]={"emacsclient -a emacs -n -c","Emacs"}, 
   ["v"]={"chromium --force-device-scale-factor=1 --app=http://netflix.com","www.netflix.com","instance"}, 
-- ["g"]={"firefox -new-window 'http://mail.google.com/mail/'","Gmail","name"}, 
   ["f"]={"urxvt -name mcTerm -e mc -d","mcTerm", "instance"}, 
   ["b"]={"urxvt -name rtorrentTerm -e rtorrent","rtorrentTerm","instance"}, 
   ["z"]={"urxvt -name mocpTerm -e mocp","mocpTerm", "instance"}, 
   ["Control-z"]={"chromium", "instance"},
--   ["Control-h"]={"urxvt -name htopTerm -e htop","htopTerm","instance"},
   ["Control-m"]={"urxvt -name muttTerm -e mutt","muttTerm","instance"},
   ["Control-w"]={"urxvt -e weechat-curses","instance"},
   ["Shift-s"]={"urxvt -name rootTerm -cr red -title rootTerm -e su","rootTerm", "instance"}, 
   ["Shift-x"]={"urxvt","urxvt", "instance"} 
}

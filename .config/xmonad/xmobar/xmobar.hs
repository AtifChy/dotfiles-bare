Config { font = "xft:JetBrains Mono:style=Bold:size=10:antialias=true:hinting=true,Symbols Nerd Font:size=11,Noto Color Emoji:size=10:antialias=true:hinting=true,Noto Sans Bengali:style=Bold:size=10,antialias=true:hinting=true"
       , additionalFonts = []
       -- , borderColor = "black"
       ,
       , bgColor = "#2e3440"
       , fgColor = "#d8dee9"
       , alpha = 255
       , position = Top
       , lowerOnStart = True
       , persistent = True
       , commands = [
                      Run Cpu ["-t", "<total>%"] 20
                    , Run Memory ["-t", "<usedratio>%"] 20
                    , Run Kbd []
                    , Run Alsa "default" "Master" ["-t", "<status><volume>%", "--", "-o", "<fc=#88c0d0>婢 </fc>", "-O", "<fc=#88c0d0>墳 </fc>"]
                    -- 婢奄奔墳
                    , Run Date "%a %F %r" "date" 10
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "<fc=#d8dee9> </fc><fc=#434c5e> | </fc>%UnsafeStdinReader% }{\
                    \    \
                    \<fc=#bf616a>\
                    \<action=`st -c st-floating -e htop -s PERCENT_CPU` button=1>\
                    \ %cpu%\
                    \</action>\
                    \</fc>\
                    \<fc=#434c5e> | </fc>\
                    \<fc=#ebcb8b>\
                    \<action=`st -c st-floating -e htop -s PERCENT_MEM` button=1>\
                    \ %memory%\
                    \</action>\
                    \</fc>\
                    \<fc=#434c5e> | </fc>\
                    \<fc=#a3be8c>\
                    \<action=`swapkeymap` button=1>\
                    \ %kbd%\
                    \</action>\
                    \</fc>\
                    \<fc=#434c5e> | </fc>\
                    \<fc=#88c0d0>\
                    \<action=`audioctl toggle` button=1>\
                    \<action=`st -c st-floating -e pulsemixer` button=3>\
                    \%alsa:default:Master%\
                    \</action>\
                    \</action>\
                    \</fc>\
                    \<fc=#434c5e> | </fc>\
                    \<fc=#b48ead>\
                    \ %date%\
                    \</fc> "
       }

-- GG's functional Xmobar configs
Config { 
    
    -- appearance
      font        = "xft:Fira Code Nerd Font:size=14:bold:antialias=true"
    , bgColor     = "#1E1E2E"
    , fgColor     = "#D9E0EE"
    , position    = Bottom
    , textOffset  = 21
    
    -- layout
    , sepChar  = "%"   -- delineator between plugin names and straight text
    , alignSep = "}{"  -- separator between left-right alignment
    , template = " %StdinReader% } %mpd% { |  %battery% %default:Master% |  %date% "
    
    -- general behavior
    , lowerOnStart     = True    -- send to bottom of window stack on start
    , hideOnStart      = False   -- start with window unmapped (hidden)
    , allDesktops      = True    -- show on all desktops
    , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
    , pickBroadest     = False   -- choose widest display (multi-monitor)
    , persistent       = True    -- enable/disable hiding (True = disabled)
    
    , commands = 
        [

        Run StdinReader

        , Run MPD [
            "--template", "<fc=#96CDFB><artist></fc> <statei> <fc=#F5C2E7><title></fc>"
            , "--"
                , "-P", "契"
                , "-Z", ""
                , "-S", "nothing playing"
        ] 10

        , Run Battery [ 
            "--template", "<acstatus>"
            , "--Low"   , "20"
            , "--High"  , "30"
            , "--low"   , "#F28FAD"
            , "--normal", "#FAE3B0"
            , "--high"  , "#ABE9B3"

            , "--" -- battery specific options
                -- discharging status
                , "-o"	, " <left>%"
                -- AC "on" status
                , "-O"	, " <left>%"
                -- charged status
                , "-i"	, " <left>%"
        ] 50

        , Run Volume "default" "Master" [ 
            "--template" , "<fc=#FAE3B0> <volume>%</fc> <status>"
            , "--"
                , "--off" , "[mute]"
                , "--onc" , "#ABE9B3"
                , "--offc", "#F28FAD"
            ] 10

        , Run Date "<fc=#F28FAD> %a %b %d  %H:%M</fc>" "date" 10

        ]
   }

-- 
-- GG's functional Xmonad configs
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Layout.SimplestFloat


-- VARIABLES {{{
--

colorBack = "#1E1E2E" -- bgdark
colorFore = "#F5C2E7" -- fgdark
-- colorBack = "#EFF1F5" -- bglight
-- colorFore = "#EA76CB" -- fglight

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myTerminal      = "st"
myBar           = "polybar"
myPP            = xmobarPP { 
    ppCurrent = xmobarColor colorFore "" . wrap "[" "]",
    ppTitle   = shorten' "" 0,
    -- ppLayout  = shorten' "" 0,
    ppOrder   = reverse
}

myBorderWidth   = 4
myModMask       = mod4Mask
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor  = colorBack
myFocusedBorderColor = colorFore

-- }}}

-- KEY BINDS {{{
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_a     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- close focused window
    , ((modm,               xK_w     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_Tab   ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm .|. shiftMask, xK_r     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm .|. shiftMask, xK_f     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm .|. shiftMask, xK_h     ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask, xK_l     ), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. controlMask, xK_q   ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. controlMask, xK_r   ), spawn "xmonad --recompile; xmonad --restart")

    --
    -- CUSTOM
    --

    -- progs
    , ((modm,               xK_n), spawn "firefox")
    , ((modm,               xK_v), spawn (myTerminal ++ " -e nvim"))
    , ((modm,               xK_m), spawn (myTerminal ++ " -e ncmpcpp"))
    , ((modm,               xK_s), spawn (myTerminal ++ " -e htop"))
    , ((modm,               xK_f), spawn (myTerminal ++ " -e lf"))
    , ((modm,               xK_u), spawn "upgrade")
    , ((modm,               xK_c), spawn (myTerminal ++ " -c st-calculator -e calculator"))
    , ((modm,               xK_p), spawn "gnome-screenshot -i")

    -- dmenu
    , ((modm .|. controlMask, xK_p), spawn "passmenu --type")
    , ((modm .|. controlMask, xK_l), spawn "dmenu_shutdown")
    , ((modm,                 xK_d), spawn "dmenu_projects")
    , ((modm,                 xK_b), spawn "dmenu_web")
    , ((modm .|. shiftMask,   xK_m), spawn "dmenu_mpd")

    -- audio
    , ((mod1Mask .|. controlMask, xK_k),     spawn "pulsevolume --increase")
    , ((mod1Mask .|. controlMask, xK_j),     spawn "pulsevolume --decrease")
    , ((mod1Mask .|. controlMask, xK_m),     spawn "pulsevolume --mute")
    , ((mod1Mask .|. controlMask, xK_p),     spawn "mpc toggle")
    , ((mod1Mask .|. controlMask, xK_l),     spawn "mpc next")
    , ((mod1Mask .|. controlMask, xK_h),     spawn "mpc prev")
    , ((mod1Mask .|. controlMask, xK_equal), spawn "mpc volume +10")
    , ((mod1Mask .|. controlMask, xK_minus), spawn "mpc volume -10")
    , ((mod1Mask .|. controlMask, xK_c),     spawn "mpc clear")

    -- etc
    , ((mod1Mask .|. controlMask, xK_x), spawn "changexmap")
    , ((mod1Mask .|. controlMask, xK_d), spawn "monitors")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_comma, xK_period, xK_slash] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- }}}

-- LAYOUTS {{{
--

myLayout = avoidStruts (tiled ||| noBorders Full ||| simplestFloat)
  where
    -- default tilling
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-- }}}

-- WINDOW RULES {{{
--

myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , className =? "Gimp"             --> doFloat 
    , className =? "st-calculator"    --> doCenterFloat
    , className =? "mpv"              --> doFloat
    , className =? "Gnome-screenshot" --> doFloat
    ]

-- }}}

-- EVENT HANDLING {{{
--

myEventHook = fullscreenEventHook

myLogHook = return ()

myStartupHook = return ()

-- }}}

-- ETC {{{

-- bar key
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. controlMask, xK_b)

-- Run xmonad
main = xmonad =<< statusBar myBar myPP toggleStrutsKey (ewmh defaults)

-- structure with config
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = handleEventHook def <+> myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
-- }}}

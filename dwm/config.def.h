/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const unsigned int gappx     = 20;        /* gaps between windows */
static const char *fonts[]          = { "UbuntuMono Nerd Font:size=15:antialias=true:hinting=true" };
static const char dmenufont[]       = "UbuntuMono Nerd Font:size=15";
static const char col_gray1[]       = "#23252E";
static const char col_gray2[]       = "#23252E";
static const char col_gray3[]       = "#ffffff";
static const char col_gray4[]       = "#ffffff";
static const char col_cyan[]        = "#2777FF";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *const autostart[] = {
	"/home/gg/.local/bin/dwmstatus.sh", NULL,
	"nitrogen", "--restore", NULL,
	"picom", NULL,
	"lxsession", NULL,
	"dunst", NULL,
	"clipmenud", NULL,
	"/home/gg/.local/bin/dwmtasks.sh", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   isterminal noswallow monitor */
	{ "Gnome-screenshot", NULL, "Screenshot",  0,          1,           0,         1,       -1 },
	{ "st"        , NULL,       NULL,       0,             0,           1,         0,       -1 },

};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "| T",      tile },    /* first entry is default */
	{ "| F",      NULL },    /* no layout function means floating behavior */
	{ "| M",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "st", NULL };

// custom commands
//
// audio
static const char *increase_vol_cmd[] = { "/home/gg/.local/bin/pamixer_volume.sh", "--increase", NULL };
static const char *decrease_vol_cmd[] = { "/home/gg/.local/bin/pamixer_volume.sh", "--decrease", NULL };
static const char *toggle_mute_cmd[] = { "/home/gg/.local/bin/pamixer_volume.sh", "--mute", NULL };
static const char *pause_cmd[] = { "cmus-remote", "-u", NULL };
static const char *next_song_cmd[] = { "cmus-remote", "-n", NULL };
static const char *previous_song_cmd[] = { "cmus-remote", "-r", NULL };

// launchers
static const char *open_browser_cmd[] = { "qutebrowser", NULL };
static const char *open_vim_cmd[] = { "st", "-e", "vim", NULL };
static const char *open_cmus_cmd[] = { "/home/gg/.local/bin/cmus_open.sh", NULL };
static const char *screenshot_cmd[] = { "gnome-screenshot", "-i", NULL };
static const char *open_email_cmd[] = { "st", "-e", "neomutt", NULL };
static const char *open_htop_cmd[] = { "st", "-e", "htop", NULL };
static const char *open_rss_cmd[] = { "st", "-e", "newsboat", NULL };

// dmenu
static const char *passmenucmd[] = { "passmenu", "--type", NULL };
static const char *clipmenucmd[] = { "clipmenu", NULL };
static const char *logoutcmd[] = { "/home/gg/.local/bin/dmenu_shutdown", NULL };
static const char *projects_menu_cmd[] = { "/home/gg/.local/bin/dmenu_projects", NULL };
static const char *web_menu_cmd[] = { "/home/gg/.local/bin/dmenu_web", NULL };
static const char *ffmpegcmd[] = { "/home/gg/.local/bin/dmenu-ffmpeg.sh", NULL };
static const char *dmenu_cmus_cmd[] = { "/home/gg/.local/bin/dmenu_cmus.sh", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_a,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ControlMask,           XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      inplacerotate,  {.i = +1} },
	{ MODKEY|ShiftMask,             XK_k,      inplacerotate,  {.i = -1} },
	{ MODKEY|ShiftMask,             XK_h,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_l,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ ControlMask|ShiftMask,        XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_w,      killclient,     {0} },
	{ MODKEY|ControlMask,           XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ControlMask,           XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ControlMask,           XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -4 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +4 } },
	{ ShiftMask|ControlMask,        XK_equal,  setgaps,        {.i = 6 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ControlMask,           XK_q,      quit,           {0} },

	// CUSTOM KEYS
	// launchers
	{ MODKEY,                       XK_n,      spawn,          {.v = open_browser_cmd } },
	{ MODKEY,                       XK_v,      spawn,          {.v = open_vim_cmd } },
	{ MODKEY,                       XK_m,      spawn,          {.v = open_cmus_cmd } },	
	{ MODKEY,                       XK_p,      spawn,          {.v = screenshot_cmd } },
	{ MODKEY,                       XK_t,      spawn,          {.v = open_email_cmd } },
	{ MODKEY,                       XK_s,      spawn,          {.v = open_htop_cmd } },
	{ MODKEY,                       XK_f,      spawn,          {.v = open_rss_cmd } },

	// dmenu
	{ MODKEY|ControlMask,           XK_p,      spawn,          {.v = passmenucmd } },
	{ MODKEY|ControlMask,           XK_c,      spawn,          {.v = clipmenucmd } },
	{ MODKEY|ControlMask,           XK_l,      spawn,          {.v = logoutcmd } },	
	{ MODKEY,                       XK_period, spawn,          {.v = projects_menu_cmd } },	
	{ MODKEY,                       XK_b,      spawn,          {.v = web_menu_cmd } },	
	{ MODKEY|ControlMask,           XK_r,      spawn,          {.v = ffmpegcmd } },	
	{ MODKEY,                       XK_c,      spawn,          {.v = dmenu_cmus_cmd } },
	
	// audio
	{ ControlMask|Mod1Mask,         XK_k,      spawn,          {.v = increase_vol_cmd } },
	{ ControlMask|Mod1Mask,         XK_j,      spawn,          {.v = decrease_vol_cmd } },
	{ ControlMask|Mod1Mask,         XK_m,      spawn,          {.v = toggle_mute_cmd } },
	{ ControlMask|Mod1Mask,         XK_p,      spawn,          {.v = pause_cmd } },
	{ ControlMask|Mod1Mask,         XK_l,      spawn,          {.v = next_song_cmd } },
	{ ControlMask|Mod1Mask,         XK_h,      spawn,          {.v = previous_song_cmd } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


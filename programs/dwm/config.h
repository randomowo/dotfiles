/* See LICENSE file for copyright and license details. */
#include "/home/randomowo/.cache/wal/colors-wal-dwm.h"

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "xos4 Terminus:size=15" };

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "fibonacci.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "|M|",      centeredmaster },		/* first entry is default */
	{ "[]=",      tile },
	{ ">M>",      centeredfloatingmaster },
 	{ "[@]",      spiral },
 	{ "[\\]",      dwindle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenuwal_run", NULL };
static const char *lreloadcmd[] = { "lreload", NULL };
static const char *passmenucmd[] = { "passmenu", NULL };
static const char *dkillcmd[] = { "dkill", NULL };
static const char *browsercmd[] = { "qutebrowser", NULL };
static const char *lowervolcmd[] = { "amixer", "set", "Master", "10%-", NULL };
static const char *raisevolcmd[] = { "amixer", "set", "Master", "10%+", NULL };
static const char *togglevolcmd[] = { "soundnotify", NULL };
static const char *shotfcmd[] = { "shot", "-f", NULL };
static const char *shotzcmd[] = { "shot", "-z", NULL };
static const char *showtimecmd[] = { "timenotify", NULL };
static const char *dbrghtnessupcmd[] = { "xbacklight", "-inc", "5", NULL };
static const char *dbrghtnessdowncmd[] = { "xbacklight", "-dec", "5", NULL };
static const char *kbrghtnessupcmd[] = { "xbacklight", "-ctrl", "smc::kbd_backlight", "-inc", "5", NULL };
static const char *kbrghtnessdowncmd[] = { "xbacklight", "-ctrl", "smc::kbd_backlight", "-dec", "5", NULL };
static const char *lockcmd[] = { "i3lock", "-k", "-ne", "--blur=5",
"--insidecolor=373445ee", "--ringcolor=555555ee", "--line-uses-inside",
"--keyhlcolor=b8a6edff", "--bshlcolor=d23c3dff", "--separatorcolor=00000044",
"--insidevercolor=373445ee", "--insidewrongcolor=373445ee",
"--ringvercolor=557755ee", "--ringwrongcolor=775555ee",
"--radius=90", "--veriftext=\"nice\"", "--wrongtext=\"WARN\"",
"--noinputtext=\"lock\"", NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ 0,							0x1008ff11,spawn,          {.v = lowervolcmd } },
	{ 0,                            0x1008ff13,spawn,          {.v = raisevolcmd } },
	{ 0,							0x1008ff12,spawn,		   {.v = togglevolcmd } },
	{ 0,							0x1008ff02,spawn,		   {.v = dbrghtnessupcmd } },
	{ 0,							0x1008ff03,spawn,		   {.v = dbrghtnessdowncmd } },
	{ 0,							0x1008ff05,spawn,		   {.v = kbrghtnessupcmd } },
	{ 0,							0x1008ff06,spawn,		   {.v = kbrghtnessdowncmd } },
	{ 0,							0x1008ff2a,spawn,          {.v = lockcmd } },
	{ MODKEY,                       XK_w,      spawn,          {.v = browsercmd } },
	{ ALTKEY,                       XK_3,      spawn,          {.v = shotfcmd } },
	{ ALTKEY,                       XK_4,      spawn,          {.v = shotzcmd } },
	{ MODKEY,                       XK_p,      spawn,          {.v = passmenucmd } },
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_q,      spawn,          {.v = dkillcmd } },
	{ MODKEY,                       XK_t,      spawn,          {.v = showtimecmd } },
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = lreloadcmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
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
	{ MODKEY,					XK_Down,	moveresize,		{.v = (int []){ 0, 25, 0, 0 }}},
	{ MODKEY,					XK_Up,		moveresize,		{.v = (int []){ 0, -25, 0, 0 }}},
	{ MODKEY,					XK_Right,	moveresize,		{.v = (int []){ 25, 0, 0, 0 }}},
	{ MODKEY,					XK_Left,	moveresize,		{.v = (int []){ -25, 0, 0, 0 }}},
	{ MODKEY|ShiftMask,			XK_Down,	moveresize,		{.v = (int []){ 0, 0, 0, 25 }}},
	{ MODKEY|ShiftMask,			XK_Up,		moveresize,		{.v = (int []){ 0, 0, 0, -25 }}},
	{ MODKEY|ShiftMask,			XK_Right,	moveresize,		{.v = (int []){ 0, 0, 25, 0 }}},
	{ MODKEY|ShiftMask,			XK_Left,	moveresize,		{.v = (int []){ 0, 0, -25, 0 }}},
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

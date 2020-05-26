/* See LICENSE file for copyright and license details. */
#include "/home/owo/.cache/wal/colors-wal-dwm.h"

/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const unsigned int gappx = 1;	/* gaps between windows */
static const unsigned int snap = 8;	/* snap pixel */
static const int vertpad = 0;       /* vertical padding of bar */
static const int sidepad = 0;       /* horizontal padding of bar */
static const int showbar = 1;		/* 0 means no bar */
static const int topbar = 0;		/* 0 means bottom bar */
static const char* fonts[] = { 
	//"xos4 Terminus:size=12",
	"monospace:size=10",
	"Noto Color Emoji:size=10",
	"TerminessTTF Nerd Font:size=9",
	"JoyPixels:size=10",
};

/* tagging */
static const char* tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    { "Gimp",	  NULL,		  NULL,		  0,			1,		     -1 },
};

/* layout(s) */
static const float mfact = 0.55;  /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;	  /* number of clients in master area */
static const int resizehints = 1; /* 1 means respect size hints in tiled resizals */

#include "fibonacci.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",	  tile }, /* first entry is default */
    { "|M|",	  centeredmaster }, 
    { ">M>",	  centeredfloatingmaster },
    { "[@]",	  spiral },
    { "[\\]",	  dwindle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define ALTKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                                                              \
    { MODKEY, KEY, view, { .ui = 1 << TAG } }, { MODKEY | ControlMask, KEY, toggleview, { .ui = 1 << TAG } },          \
	{ MODKEY | ShiftMask, KEY, tag, { .ui = 1 << TAG } },                                                          \
	{ MODKEY | ControlMask | ShiftMask, KEY, toggletag, { .ui = 1 << TAG } },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                                                                     \
    {                                                                                                                  \
	.v = (const char*[]) { "/bin/sh", "-c", cmd, NULL }                                                            \
    }

static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char* dmenucmd[] = { "dmenuwal_run", NULL };

static Key keys[] = {
    /* modifier           key         function        argument */
    { 0,				  0x1008ff11, spawn,		  SHCMD("changevolume -") },
    { 0,				  0x1008ff13, spawn,		  SHCMD("changevolume +") },
    { 0,				  0x1008ff12, spawn,		  SHCMD("changevolume 0") },
    { 0,				  0x1008ff02, spawn,		  SHCMD("changebackligt m+") },
    { 0,				  0x1008ff03, spawn,		  SHCMD("changebackligt m-") },
    { 0,				  0x1008ff05, spawn,		  SHCMD("changebackligt k+") },
    { 0,				  0x1008ff06, spawn,		  SHCMD("changebackligt k-") },
    { 0,				  0x1008ff4a, spawn,		  SHCMD("scrsw") },
    { MODKEY,			  XK_w,		  spawn,		  SHCMD("$BROWSER") },
    { ALTKEY,			  XK_3,		  spawn,		  SHCMD("shot -f") },
    { ALTKEY,			  XK_4,		  spawn,		  SHCMD("shot -z") },
    { ALTKEY | ShiftMask, XK_4,		  spawn,		  SHCMD("shot -a") },
    { ALTKEY,			  XK_5,		  spawn,		  SHCMD("srecord") },
    { MODKEY,			  XK_d,		  spawn,		  SHCMD("dmenuwal_run") },
    { MODKEY,			  XK_q,		  spawn,		  SHCMD("dkill") },
    { MODKEY,			  XK_t,		  spawn,		  SHCMD("timenotify") },
    { MODKEY,			  XK_e,		  spawn,		  SHCMD("emenu") },
    { MODKEY | ShiftMask, XK_r,		  spawn,		  SHCMD("lreload") },
    { MODKEY,			  XK_r,		  spawn,		  SHCMD("st -e ranger") },
    { MODKEY | ShiftMask, XK_Return,  spawn,		  SHCMD("$TERMINAL") },
    { MODKEY,			  XK_b,		  togglebar,	  { 0 } },
    { MODKEY,			  XK_j,		  focusstack,	  { .i = +1 } },
    { MODKEY,			  XK_k,		  focusstack,	  { .i = -1 } },
    { MODKEY,			  XK_i,		  incnmaster,	  { .i = +1 } },
    { MODKEY | ShiftMask, XK_i,		  incnmaster,	  { .i = -1 } },
    { MODKEY,			  XK_h,		  setmfact,		  { .f = -0.05 } },
    { MODKEY,			  XK_l,		  setmfact,		  { .f = +0.05 } },
    { MODKEY,			  XK_Return,  zoom,			  { 0 } },
    { MODKEY,			  XK_Tab,	  view,			  { 0 } },
    { MODKEY | ShiftMask, XK_q,		  killclient,	  { 0 } },
    { MODKEY | ShiftMask, XK_t,		  setlayout,	  { .v = &layouts[0] } },
    { MODKEY | ShiftMask, XK_f,		  setlayout,	  { .v = &layouts[1] } },
    { MODKEY,			  XK_m,		  setlayout,	  { .v = &layouts[2] } },
    { MODKEY,			  XK_u,		  setlayout,	  { .v = &layouts[3] } },
    { MODKEY,			  XK_o,		  setlayout,	  { .v = &layouts[4] } },
    { MODKEY,			  XK_space,	  setlayout,	  { 0 } },
    { MODKEY | ShiftMask, XK_space,   togglefloating, { 0 } },
    { MODKEY,			  XK_f,		  togglefullscr,  { 0 } },
    { MODKEY,			  XK_0,		  view,			  { .ui = ~0 } },
    { MODKEY | ShiftMask, XK_0,		  tag,			  { .ui = ~0 } },
    { MODKEY,			  XK_comma,	  focusmon,		  { .i = -1 } },
    { MODKEY,			  XK_period,  focusmon,		  { .i = +1 } },
    { MODKEY | ShiftMask, XK_comma,	  tagmon,		  { .i = -1 } },
    { MODKEY | ShiftMask, XK_period,  tagmon,		  { .i = +1 } },
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
	TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7) TAGKEYS(XK_9, 8) { MODKEY | ControlMask, XK_q, quit, { 0 } },
    { MODKEY,			  XK_Down,    moveresize,	  { .v = (int[]) { 0, 25, 0, 0 } } },
    { MODKEY,			  XK_Up,	  moveresize,	  { .v = (int[]) { 0, -25, 0, 0 } } },
    { MODKEY,			  XK_Right,   moveresize,	  { .v = (int[]) { 25, 0, 0, 0 } } },
    { MODKEY,			  XK_Left,	  moveresize,	  { .v = (int[]) { -25, 0, 0, 0 } } },
    { MODKEY | ShiftMask, XK_Down,    moveresize,	  { .v = (int[]) { 0, 0, 0, 25 } } },
    { MODKEY | ShiftMask, XK_Up,	  moveresize,	  { .v = (int[]) { 0, 0, 0, -25 } } },
    { MODKEY | ShiftMask, XK_Right,   moveresize,	  { .v = (int[]) { 0, 0, 25, 0 } } },
    { MODKEY | ShiftMask, XK_Left,    moveresize,	  { .v = (int[]) { 0, 0, -25, 0 } } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,			0,				Button1,		setlayout,		{ 0 } },
    { ClkLtSymbol,			0,				Button3,		setlayout,		{ .v = &layouts[2] } },
    { ClkWinTitle,			0,				Button2,		zoom,			{ 0 } },
    { ClkStatusText,		0,				Button2,		spawn,			SHCMD("$TERMINAL") },
    { ClkClientWin,			MODKEY,			Button1,		movemouse,		{ 0 } },
    { ClkClientWin,			MODKEY,			Button2,		togglefloating, { 0 } },
    { ClkClientWin,			MODKEY,			Button3,		resizemouse,	{ 0 } },
    { ClkTagBar,			0,				Button1,		view,			{ 0 } },
    { ClkTagBar,			0,				Button3,		toggleview,		{ 0 } },
    { ClkTagBar,			MODKEY,			Button1,		tag,			{ 0 } },
    { ClkTagBar,			MODKEY,			Button3,		toggletag,		{ 0 } },
};

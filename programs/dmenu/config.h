/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */
#include "/home/owo/.cache/wal/colors-wal-dmenu.h"
// change owo to your username

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
//	"xos4 Terminus:size=12"
	"monospace:size=10",
	"Noto Color Emoji:size=10",
	"TerminessTTF Nerd Font:size=9",
	"JoyPixels:size=10",
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 10;
static unsigned int lineheight = 0;         /* -h option; minimum height of a menu line     */

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

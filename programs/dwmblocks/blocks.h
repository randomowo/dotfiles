//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_record.sh",		5,		5},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_battery.sh",		10,		10},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_cputemp.sh",		5,		10},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_cpuusage.sh",		5,		10},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_backlight.sh",	1,		0},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_pulse.sh",		1,		0},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_network.sh",		10,		10},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_weather.sh",		3600,	60},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_date.sh",			1,		0},
	
};

// set block limeters (only 2 chars)
// NULL ('\0') means no limiters
static char *delim = "[]";

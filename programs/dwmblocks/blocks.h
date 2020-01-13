//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_battery.sh",							10,		10},
	{" ", " sensors | grep -E 'Package.*' | grep -oE '+[0-9]{1,3}' | xargs | cut -d' ' -f2",		5,		10},
	{" ", "xbacklight -get",																	1,		0},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_pulse.sh",							1,		0},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_network.sh",							10,		10},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_weather.sh",							60,		60},
	{"", "~/dotfiles/programs/dwmblocks/bar-functions/dwm_date.sh",								1,		0},
	
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';

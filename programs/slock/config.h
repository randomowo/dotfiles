/* user and group to drop privileges to */
static const char *user  = "owo";
static const char *group = "owo";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#131314",     /* after initialization */
	[INPUT] =  "#2D5753",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
	[CAPS] = "#A25648",         /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "show what you can";

/* text color */
static const char * text_color = "#d4c3a3";

/* text size (must be a valid size) */
static const char * font_name = "-xos4-terminus-bold-r-normal--32-320-72-72-c-160-iso10646-1";

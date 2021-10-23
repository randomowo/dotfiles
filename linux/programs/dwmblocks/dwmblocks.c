#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include<signal.h>
#include<X11/Xlib.h>
#define LENGTH(X)               (sizeof(X) / sizeof (X[0]))
#define CMDLENGTH       50

typedef struct {
    char* icon;
    char* command;
    unsigned int interval;
    unsigned int signal;
} Block;
void sighandler(int num);
void getcmds(int time);
#ifndef __OpenBSD__
void getsigcmds(int signal);
void setupsignals();
void sighandler(int signum);
#endif
int getstatus(char *str, char *last);
void setroot();
void statusloop();
void termhandler(int signum);


#include "blocks.h"

static Display *dpy;
static int screen;
static Window root;
static char statusbar[LENGTH(blocks)][CMDLENGTH] = {0};
static char statusstr[2][256];
static int statusContinue = 1;
static void (*writestatus) () = setroot;

//opens process *cmd and stores output in *output
void getcmd(const Block *block, char *output, int isLast)
{
    char *cmd = block->command;
    FILE *cmdf = popen(cmd,"r");
    if (!cmdf) return;
    int ii = strlen(block->icon);
    strcpy(output, block->icon);
    fgets(output+ii, CMDLENGTH-ii, cmdf);
    int i = strlen(output);
    int di = strlen(delim);
    if (i-1 && di) {
        int hdi = di/2;
        strncpy(output+hdi, output, i);
        i += hdi;
        strncpy(output, delim+(di-hdi), hdi);
        strncpy(output+i-1, delim, di-hdi);
        i += di-hdi;
    }
    if (isLast && !(di%2)) {
        printf("oi:%d i:%d", strlen(output), i);
        output[i++-1] = ' ';
    }
    output[--i] = '\0';
    printf("%s\n", output);
    pclose(cmdf);
}

void getcmds(int time)
{
    const Block* current;
    for(int i = 0; i < LENGTH(blocks); i++)
    {
        current = blocks + i;
        if ((current->interval != 0 && time % current->interval == 0) || time == -1)
            getcmd(current, statusbar[i], i+1 == LENGTH(blocks));
    }
}

#ifndef __OpenBSD__
void getsigcmds(int signal)
{
    const Block *current;
    for (int i = 0; i < LENGTH(blocks); i++)
    {
        current = blocks + i;
        if (current->signal == signal)
            getcmd(current, statusbar[i], i+1 == LENGTH(blocks));
    }
}

void setupsignals()
{
    for(int i = 0; i < LENGTH(blocks); i++)
    {
        if (blocks[i].signal > 0)
            signal(SIGRTMIN+blocks[i].signal, sighandler);
    }

}
#endif

int getstatus(char *str, char *last)
{
    strcpy(last, str);
    str[0] = '\0';
    for(int i = 0; i < LENGTH(blocks); i++)
        strcat(str, statusbar[i]);
    str[strlen(str)-1] = '\0';
    return strcmp(str, last);//0 if they are the same
}

void setroot()
{
    if (!getstatus(statusstr[0], statusstr[1]))//Only set root if text has changed.
        return;
    Display *d = XOpenDisplay(NULL);
    if (d) {
        dpy = d;
    }
    screen = DefaultScreen(dpy);
    root = RootWindow(dpy, screen);
    XStoreName(dpy, root, statusstr[0]);
    XCloseDisplay(dpy);
}

void pstdout()
{
    if (!getstatus(statusstr[0], statusstr[1]))//Only write out if text has changed.
        return;
    printf("%s\n",statusstr[0]);
    fflush(stdout);
}


void statusloop()
{
#ifndef __OpenBSD__
    setupsignals();
#endif
    int i = 0;
    getcmds(-1);
    while(statusContinue)
    {
        getcmds(i);
        writestatus();
        sleep(1.0);
        i++;
    }
}

#ifndef __OpenBSD__
void sighandler(int signum)
{
    getsigcmds(signum-SIGRTMIN);
    writestatus();
}
#endif

void termhandler(int signum)
{
    statusContinue = 0;
    exit(0);
}

int main(int argc, char** argv)
{
    for(int i = 0; i < argc; i++)
    {
        if (!strcmp("-d",argv[i]))
            delim = argv[++i];
        else if(!strcmp("-p",argv[i]))
            writestatus = pstdout;
    }
    signal(SIGTERM, termhandler);
    signal(SIGINT, termhandler);
    statusloop();
}

#ifndef _GLOBAL_H_
#define _GLOBAL_H_

extern int daemonize;
extern int verbose;

extern const char* PROGRAM_NAME;
extern const char* PROGRAM_VERSION;
extern const char* PROGRAM_PID;

struct s_sensors {
    FILE* file;
    char* path;
    unsigned int temperature;
    struct s_sensors *next;
};

struct s_fans {
    FILE* file;
    char* path;  // TODO: unused
    char* label;
    char* fan_output_path;
    char* fan_manual_path;
    int step_up;
    int step_down;
    int fan_id;
    int old_speed;
    int fan_max_speed;
    int fan_min_speed;
    struct s_fans *next;
};

typedef struct s_sensors t_sensors;
typedef struct s_fans t_fans;

extern t_sensors* sensors;
extern t_fans* fans;

#endif
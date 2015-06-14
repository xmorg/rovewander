#include <time.h> //for localtime

struct tm *timeinfo; //

void get_clocaltime(struct tm *t);
void printf_localtime();

void get_clocalltime(struct tm *t)
{
  time_t rawtime;
  time( &rawtime);
  timeinfo = localtime( &rawtime ); //get time struct
}

#include <stdio.h>
 
void printf_localtime(struct tm *t)
{
  printf("asctime: %s\n", asctime(t) );
}


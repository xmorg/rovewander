#include <time.h> //for localtime

struct tm *timeinfo; //

void get_clocaltime(struct tm *t);
void printf_localtime();


#include <stdio.h>
#include <stdlib.h>
char * get_asclocalltime()
{
  char *texttime;
  time_t rawtime;

  texttime = (char*)malloc(25 * sizeof(char));
  
  time( &rawtime);
  timeinfo = localtime( &rawtime ); //get time struct
  sprintf(texttime, "%s\n", asctime(timeinfo));
  return texttime;
  
}

#include <stdio.h>
 
void printf_localtime()
{
  time_t rawtime;
  time( &rawtime);
  timeinfo = localtime(&rawtime);
  printf("asctime: %s\n", asctime(timeinfo) );
  
}


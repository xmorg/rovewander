#Makefile for mySDL

CC = clang `pkg-config --cflags gtk+-3.0`

LIBS = `pkg-config --libs gtk+-3.0`

FLAGS = `pkg-config --cflags gtk+-3.0` 

FILES = menus.c \
	shapes.c \
	datetime.c \
	gtk_app_basic.c \
	text.c \

all:
	$(CC) -o cal_gtk $(FILES) $(FLAGS) $(LIBS)

clean:
	@echo Cleaning up...
	@echo Erasing exec
	@rm cal_gtk
	@echo Erasing emacs backups
	@rm *.*~
	@rm *.o
	@rm *.core
	@echo Done.

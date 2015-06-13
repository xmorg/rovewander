#Makefile for mySDL

CC = clang `pkg-config --cflags gtk+-3.0`

LIBS = `pkg-config --libs gtk+-3.0`

FLAGS = `pkg-config --cflags gtk+-3.0` 

FILES = menus.c \
	shapes.c \
	gtk_app_basic.c \


all:
	$(CC) -o cal_gtk $(FILES) $(FLAGS) $(LIBS)

clean:
	@echo Cleaning up...
	@echo Erasing exec
	@rm cal_gtk
	@echo Erasing emacs backups
	@rm src/*.*~
	@rm src/*.o
	@rm *.core
	@echo Done.

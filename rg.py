#/usr/bin/python3

import random
import pygame
from pygame.locals import *
#from OpenGL.GL import *
#from OpenGL.GLU import *

#from GameMap import GameMap
from NewPlayerWindow import NewPlayerWindow
from Resources import Resources
from Scene import Scene


class Game:
    def __init__(self):
        self.tilesize = 32
        self.tilespacing = 0
        self.display = (800,600)
        self.scr = pygame.display.set_mode(self.display, DOUBLEBUF)
        #self.gm = GameMap()
        self.game_state = "playing"
        self.game_window = "newplayer" #title, newplayer,localmap,worldmap,inventory,charisma
        self.scene = Scene(self.scr, self.tilesize, None)

    def load(self):
        self.resources = Resources(self.tilesize)
        self.scene.setResources(self.resources)
        self.newplayerwindow = NewPlayerWindow(self.scr, \
                                               self.resources.chartileset)
        for i in range(0, 38):
            r = (self.tilesize*i +0, 0, self.tilesize,self.tilesize)
            self.resources.loadSpritesToSet(r)
    def blt(self, s, dest):
        self.scr.blit(s, dest)
    def draw(self):
        self.scr.fill( (0,0,0) )
        if self.game_window == "newplayer":
            self.newplayerwindow.draw()
        elif self.game_window == "localmap":
            self.scene.draw()
        else:
            self.scene.draw()
        pygame.display.flip()
        pygame.time.wait(10)
    def input(self):
        key = pygame.key.get_pressed()
        if key[pygame.K_RIGHT]:
            return "playing"
        elif key[pygame.K_LEFT]:
            return "playing"
        elif key[pygame.K_ESCAPE]:
            #event.type = pygame.QUIT
            return "exit"
        else:
            return "playing"
def main():
    pygame.init()
    game = Game()
    game.load()
    
    while game.game_state == "playing":
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                print("debug: you wanted to quit?")
                pygame.quit()
            if event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
                game.game_state = "exit"
                #pygame.event.post(pygame.QUIT)
                pygame.quit()
        if game.game_window == "newplayer":
            game.game_window = game.newplayerwindow.input()
        #else:
        #    game.game_window = game.input()
        game.draw()
        #print("game_state = ", game_state, "loop again")
    print("somehow you got to the end of the loop")
main()


#/usr/bin/python3

import random
import pygame
from pygame.locals import *
#from OpenGL.GL import *
#from OpenGL.GLU import *

from GameMap import GameMap

class Resources:
    def __init__(self, tiles, t):
        self.tilesize = t
        self.tiles = pygame.image.load(tiles)
class Game:
    def __init__(self):
        self.tilesize = 32
        self.tilespacing = 0
        self.display = (800,600)
        self.scr = pygame.display.set_mode(self.display, DOUBLEBUF)
        self.gm = GameMap()
    def load(self):
        self.worldtiles = Resources("worldtiles.png", self.tilesize)
        self.localtiles = Resources("localtiles.png", self.tilesize)
        self.charactertiles = Resources("characters.png", self.tilesize)
        self.monstertiles = Resources("monsters.png", self.tilesize)
        self.worldtileset = []
        self.localtileset = []
        self.chartileset = []
        self.monstertileset = []
        for i in range(0, 20):
            #+i
            r = (self.tilesize*i +0, 0, self.tilesize,self.tilesize)
            self.worldtileset.append(self.worldtiles.tiles.subsurface(r))
            self.localtileset.append(self.worldtiles.tiles.subsurface(r))
            self.chartileset.append(self.worldtiles.tiles.subsurface(r))
            self.monstertileset.append(self.worldtiles.tiles.subsurface(r))
    def blt(self, s, dest):
        self.scr.blit(s, dest)
    def draw(self):
        self.scr.fill( (0,0,0) )
        t = self.tilesize #16, 32, 64, etc
        
        for y in range(0,40):
            for x in range(0,50):
                data = self.gm.data[y][x]
                self.blt(self.worldtileset[data], (x*t, y*t) )
            
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
    game_state = "playing"
    while game_state == "playing":
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                print("debug: you wanted to quit?")
                pygame.quit()
            if event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
                game_state = "exit"
                #pygame.event.post(pygame.QUIT)
                pygame.quit()
        game_state = game.input()
        game.draw()
        #print("game_state = ", game_state, "loop again")
    print("somehow you got to the end of the loop")
main()


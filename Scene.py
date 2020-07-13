import pygame

from GameMap import GameMap

class Scene:
    def __init__(self, screen, t, r):
        self.screen = screen
        self.tilesize = t
        self.gm = GameMap()
        self.resources = r #get resources from game.resources
    def setResources(self, r):
        self.resources = r
    def blt(self, s, dest):
        self.screen.blit(s, dest)
    def draw(self):
        #draw the stuff
        t = self.resources.tilesize
        for y in range(0,40):
            for x in range(0,50):
                data = self.gm.data[y][x]
                self.blt(self.resources.worldtileset[data], (x*t, y*t) )

import pygame
from Actor import Actor

class Resources:
    def __init__(self, t):
        self.tilesize = t
        #self.tiles = pygame.image.load(tiles)
        self.worldtiles = pygame.image.load("data/worldtiles.png")
        self.localtiles = pygame.image.load("data/localtiles.png")
        self.charactertiles = pygame.image.load("data/characters.png" )
        self.monstertiles = pygame.image.load("data/monsters.png")
        self.worldtileset = []
        self.localtileset = []
        self.chartileset = []
        self.monstertileset = []
        self.player = Actor() #you the player
    def loadSpritesToSet(self, r):
        self.worldtileset.append(self.worldtiles.subsurface(r))
        self.localtileset.append(self.localtiles.subsurface(r))
        self.chartileset.append(self.charactertiles.subsurface(r))
        self.monstertileset.append(self.monstertiles.subsurface(r))

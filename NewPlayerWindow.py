import pygame

class NewPlayerWindow:
    def __init__(self, screen, t):
        self.tiles = t
        self.screen = screen
    def blt(self, s, dest):
        self.screen.blit(s, dest)
    def draw(self): #draw the window/screen
        self.screen.blit(t, (0,0)

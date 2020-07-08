import pygame
from Actor import Actor

playerlist = []

class NewPlayerWindow:
    def __init__(self, screen, t):
        self.tiles = t
        self.screen = screen
        self.keywaspressed = False
        self.wintimer = 0
        pygame.font.init() # you have to call this at the start, 
        # if you want to use this module.
        self.fcolor = (200, 200, 200)
        self.myfont = pygame.font.SysFont('Comic Sans MS', 30)
        self.label0 = self.myfont.render('Select thy personage.', \
                                         False, self.fcolor )
        self.medfont = pygame.font.SysFont('Comic Sans MS', 24)
        
        self.Rgoth  = self.medfont.render('Goth', False, self.fcolor)
        self.Rhun   = self.medfont.render('Hun', False, self.fcolor)
        self.Rmoor  = self.medfont.render('Moor', False, self.fcolor)
        self.Relf   = self.medfont.render('Elf', False, self.fcolor)
        self.Rdwarf = self.medfont.render('Dwarf', False, self.fcolor)      
        self.Rgnome = self.medfont.render('Gnome', False, self.fcolor)
        

        self.JCommoner = self.medfont.render('Commoner', False, self.fcolor)
        self.Jmage = self.medfont.render('Mage', False, self.fcolor)
        self.JFighter = self.medfont.render('Fighter', False, self.fcolor)
        self.JRogue = self.medfont.render('Rogue', False, self.fcolor)

        #self.Smale = 
        self.Lname = self.medfont.render('Name: ', False, self.fcolor)
        self.Lsex = self.medfont.render('Sex: ', False, self.fcolor)
        self.LsexMale = self.medfont.render('Male', False, self.fcolor)
        self.LsexFemale = self.medfont.render('Female', False, self.fcolor)
        self.Lrace = self.medfont.render('Race: ', False, self.fcolor)
        self.Ljob = self.medfont.render('Job: ', False, self.fcolor)
        
        self.selectx = 0
        self.selecty = 0
    def blt(self, s, dest):
        self.screen.blit(s, dest)
    def raceSelected(self, x, y):
        if y == 0 or y == 1:
            return self.Rgoth
        elif y == 2 and ( x == 0 or x == 1 ):
            return self.Rhun
        elif y == 2 and ( x >= 2 ):
            return self.Rmoor
        elif y == 3:
            return self.Relf
        elif y == 4:
            if x < 4:
                return self.Rdwarf
            else:
                return self.Rgnome
        else:
            return self.Rgoth
    def draw(self): #draw the window/screen
        self.wintimer += 1
        self.timertick = 7
        if self.wintimer >= 8:
            self.wintimer = 0
        self.screen.fill( (0,0,0))
        self.blt(self.label0, (10,10) )
        #self.blt(self.tiles[2], (10,50))
        tilecount = 2
        for y in range(0,6):
            for x in range(0,6):
                if x == self.selectx and y == self.selecty:
                    pygame.draw.rect(self.screen,\
                                     (200,165,165),\
                                     (x*32+ x*10+15, 50+y*32+y*50+15,32,32) )
                self.blt(self.tiles[tilecount], \
                         (x*32+ x*10+15, 50+ y*32+ y*50+15))
                tilecount = tilecount + 1
        #sx = self.selectx *32 + x*10+15
        #sy = self.selecty *32 + y*50+15
        #pygame.draw.rect(self.screen, (200,160,160), (sx,sy,32,32) )
        pygame.draw.rect(self.screen, (200,200,200), (300,50,4,500) )
        self.blt(self.Lname, (330, 50) )
        self.blt(self.Lsex,  (330, 50 +24) )
        if(self.selectx== 0 or self.selectx == 2 or self.selectx == 4):
           self.rendersex = self.LsexMale
        else:
           self.rendersex = self.LsexFemale
        self.blt(self.rendersex, (380, 50+24) )
        self.blt(self.Lrace, (330, 50 +24*2) )
        self.blt(self.raceSelected(self.selectx, self.selecty), (380, 50 +24*2) )
        self.blt(self.Ljob,  (330, 50 +24*3) )
    def input(self):
        key = pygame.key.get_pressed()
        #pygame.key.set_repeat(0,1)
        if self.selectx < 0: self.selectx = 0
        if self.selectx > 5: self.selectx = 5
        if self.selecty < 0: self.selecty = 0
        if self.selecty > 5: self.selecty = 5
        print("selectx = "+str(self.selectx)+" selecty = "+str(self.selecty))
        if key[pygame.K_RIGHT]:# and self.keywaspressed == False:
            if self.selectx < 6:
                if self.wintimer == self.timertick:
                    self.selectx += 1
                self.keywaspressed = True
                return "newplayer"
        elif key[pygame.K_LEFT]:# and self.keywaspressed == False:
            if self.selectx > -1:
                if self.wintimer == self.timertick:
                    self.selectx -= 1
                self.keywaspressed = True
                return "newplayer"
        elif key[pygame.K_UP]:# and self.keywaspressed == False:
            if self.selecty > -1:
                if self.wintimer == self.timertick:
                    self.selecty -= 1
                self.keywaspressed = True
                return "newplayer"
        elif key[pygame.K_DOWN]:# and self.keywaspressed == False:
            if self.selecty < 6:
                if self.wintimer == self.timertick:
                    self.selecty += 1
                self.keywaspressed = True
                return "newplayer"
        else:
            return "newplayer"

#/usr/bin/python3
#using  Basic fantasy RPG Rules

class Actor:
    def __init__(self):
        self.name      = 'none'
        self.race      = 'Goth'
        self.job       = 'commoner'
        self.level     = 1
        self.exp       = 0
        # abilities/ Attrib
        self.strength  = 1
        self.intl      = 1
        self.wisdom    = 1
        self.dexterity = 1
        self.con       = 1
        self.cha       = 1
        self.armorc    = 20
        self.hitpts    = 5
        self.hitmax    = 0
        self.atkbonus  = 0
        self.inventory = []
        self.maxweight = 30

        #saving throws
        self.save_death = 0 # death/poison
        self.save_wand  = 0 # magic from wands
        self.save_para  = 0 #paralysis/stone
        self.save_breath = 0
        self.save_spell = 0
        #skills - thief
        self.open_locks = 0
        self.traps      = 0
        self.p_pockets  = 0
        self.stealth    = 0
        self.climbing   = 0
        self.hiding     = 0
        self.awareness = 0
        #skills - social
        self.seduce = 0 #perswade members of the opposite sex
        self.haggle = 0 #fast talking and bargening
        self.oration = 0 #give a rousing speech.
        self.intimidate = 0
    def setname(self, name):
        self.name = name
    def set_abilities(self, s,i,w,d,c,ch):
        self.strength  = s
        self.intl      = i
        self.wisdom    = w
        self.dexterity = d
        self.con       = c
        self.cha       = ch
    def incr_abilities(self, s,i,w,d,c,ch):
        self.strength  += s
        self.intl      += i
        self.wisdom    += w
        self.dexterity += d
        self.con       += c
        self.cha       += ch
    def setskills_social(self, s, h, o, i):
        self.seduce = s #perswade members of the opposite sex
        self.haggle = h #fast talking and bargening
        self.oration = o #give a rousing speech.
        self.intimidate = i
    def setskills_thief(self, o, t, p, s, c, h, a):
        self.open_locks = o
        self.traps      = t
        self.p_pockets  = p
        self.stealth    = s
        self.climbing   = c
        self.hiding     = h
        self.awareness  = a
    def set_savingthrows(self, d,w,p,b,s):
        self.save_death = d # death/poison
        self.save_wand  = w # magic from wands
        self.save_para  = p #paralysis/stone
        self.save_breath = b
        self.save_spell = s
    def rebuildBaseActor(s, r, j): #sex race job
        if r == 'Goth':
            #self.setskills_social( s, h, o, i)
            #self.setskills_thief(o, t, p, s, c, h, a)
            self.set_abilities(5,5,5,5,5,5)
            self.set_savingthrows(0,1,0,0,0)
            self.setskills_social(1, 1, 1, 1)
            self.setskills_thief(0, 0, 0, 0, 0, 0, 0)
        elif r == 'Hun':
            self.set_abilities(7,4,4,5,8,2)
            self.set_savingthrows(0,0,0,2,0)
            self.setskills_social(0, 1, 0, 3)
            self.setskills_thief(0, 0, 1, 1, 2, 1, 3)
        elif r == 'Moor':
            self.set_abilities(5,5,6,6,4,4)
            self.set_savingthrows(1,0,0,0,1)
            self.setskills_social( 1, 2, 0, 1)
            self.setskills_thief(1, 1, 1, 2, 0, 1, 1)
        elif r == 'Elf':
            self.set_abilities(4,6,6,7,3,4)
            self.set_savingthrows(0,1,1,0,0)
            self.setskills_social( 1, 0, 1, 0)
            self.setskills_thief(0, 1, 0, 2, 1, 2, 3)
        elif r == 'Dwarf':
            self.set_abilities(7,4,6,4,7,4)
            self.set_savingthrows(1,0,0,1,0)
            self.setskills_social( 0, 3, 2, 1)
            self.setskills_thief(1, 3, 1, 0, 0, 0, 0)
        elif r == 'Gnome':
            self.set_abilities(2,8,4,7,3,6)
            self.set_savingthrows(1,0,0,0,1)
            self.setskills_social( 0, 2, 1, 0)
            self.setskills_thief(2, 2, 2, 1, 0, 2, 1)
        else:
            self.set_abilities(5,5,5,5,5,5)
            self.set_savingthrows(0,0,0,0,0)
            self.setskills_social( 0, 2, 1, 0)
            self.setskills_thief(2, 2, 2, 1, 0, 2, 1)
        

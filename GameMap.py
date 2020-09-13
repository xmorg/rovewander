import random

class GameMap:
    def __init__(self):
        self.data = [] # init a variable for a data list
        self.map_size_x = 50
        self.map_size_y = 40
        for y in range(0, self.map_size_y):
            d = []
            for x in range(0,50):
                i = random.randint(0,self.map_size_x)
                d.append(i)
            self.data.append(d) 

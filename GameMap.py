import random

class GameMap:
    def __init__(self):
        self.data = []
        for y in range(0,40):
            d = []
            for x in range(0,50):
                i = random.randint(0,15)
                d.append(i)
            self.data.append(d) 

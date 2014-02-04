playable_race_names = {	{"Human", "short-lived hardworking folk of the midland kingdoms"}, --one of the 
	{"HalfElf", "humans who can trace their bloodlines to an elven heritage."},
	{"Norlander",  "tall humans who live in the frozen wastes of the north."},
	{"Nomad",  "mix of tribal humans who wander the lands and trade horses and livestock."},
	{"Elf",  "fair folk, who have made their home in the midland."},
	{"Dark Elf",  "dread ones, or the Rock Elves.  The Dark Elves live deep in the earth and often clash with dwarves."},
	{"High Elf",  "kingdom Elves, who live in the Elven Kingdoms of the mystic Isles."},
	{"Wild Elf",  "wild Elves live in the great forrests of the midlands, and the northern snowpines."},
	{"Gnome", "elusive advanced race of mechanical geniuses."},
	{"Dwarf",  "short stout humanoids who live in the mountains and build great holds out of soid rock."},
	{"Abyss Dwarf", "redskinned dwarves are known for delving deeply and creating mythical lava forges."}, 
	{"Topside Dwarf",  "Dwarves who have built great kingdoms in the earth, and often merge with human kingdoms."},
	{"Goblin", "small devious creatures, which live almost everyhwere and bother almost everyone."},
	{"Orc",  "large race of barbaric humanoids who look like giant furry goblins."},
	{"Trorc",  "halftroll who are a hybrid creature, created by dark experiments.  They are few in number but large, strong and violent."},
	{"Owlman",  "reclusive winged humanoids, who inhabid the winded craigs of the southland."},
	{"Catman",  "feline humanoids who live the deep forests that blur the lines between men and beast. Catmen are wise fast, and furry."},
	{"Ratigan",  "race of ratmen, not to be confused with the were-rat.   Ratigans, were once as numerous as goblins, but now live in caves."},
	{"Mermen", "mythical aquatic peoples that rule the sea as men rule the land.  They are in constant war with the Naga."},
	{"Harepon",  "feral birdmen which live live on remote islands are are a constant nuisance to shipping."},
	{"Locustin",  "lords of the the crop wasters, are giant locust-man.  Many years ago the midland kings pushed their kind far to the east."},
	{"Lizardman",  "scaled ones, are an ancient race, which once ruled the midland. Their numbers declined for an unknown reason, and they remain in the western isles."},
	{"Naga", "a vicious races of snakemen, often called mersnakes.  They have a dubious alliance with the Lizardmen."}
}	

crude_names_front = {"Al", "Bre", "Cel", "Dan", "Ed", "Ford", "Guy", "Haus", "Ister",
	"Jim", "Kael", "Liam", "Mor", "Nast", "Oh", "Pel", "Qin", "Ray", "Sten","Tell",
	"Urst", "Val", "Wist", "Xen", "Yor", "Zum"
}
crude_names_back = {"ane", "eber", "ic", "od", "ue", "af", "eg", "him", "oi",
	"aj", "ek", "ille", "om", "un", "ao", "ep", "quipp", "or", "us","at",
	"eur", "iv", "ow", "ux", "ay", "ez"
}

require("primatives")

function race_if_an(a)
	if a.a_type == playable_race_names[5][1] then
		return "n Elf"
	elseif a.sex == 0 and a.a_type == "Mermen" then
		return " mermaid"
	elseif a.sex == 0 and a.a_type == "Harepon" then
		return " harpy"
	elseif a.sex == 0 and a.a_type == "Catman" then
		return " catwoman"
	elseif a.sex == 0 and a.a_type == "Owlman" then
		return " owlwoman"
	else
		return " "..a.a_type
	end
end
function sex_if_an(a)
	if a.sex == 0 then
		return "female"
	else
		return "male"
	end
end
function display_actor_stats(actor, editing)--actor object, boolean viewable
	local line_num = 3
	local coll_one = 20
	local coll_two = 200
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("Name: ".. actor.name, coll_one, line_num*14)
	love.graphics.print("Race: ".. actor.a_type, coll_two, line_num*14) 
	love.graphics.print("Sex: "..sex_if_an(actor), coll_two+200, line_num*14) line_num=line_num+1
	love.graphics.print("=======================================", coll_one, line_num*14)line_num=line_num+1
	
	love.graphics.printf(actor.background, coll_two, line_num*14, 300, "left")
	
	love.graphics.print("Strength :", coll_one, line_num*14) 
		love.graphics.print( actor.strength, coll_one+100, line_num*14) line_num=line_num+1
	love.graphics.print("Agility :", coll_one, line_num*14) 
		love.graphics.print(actor.agility,coll_one+100, line_num*14) line_num=line_num+1
	love.graphics.print("Intelligence:", coll_one, line_num*14)
		love.graphics.print( actor.intel,coll_one+100, line_num*14) line_num=line_num+1
	love.graphics.print("Stamina:", coll_one, line_num*14)
		love.graphics.print( actor.stamina, coll_one+100, line_num*14) line_num=line_num+1
	love.graphics.print("Luck:", coll_one, line_num*14)
		love.graphics.print( actor.luck, coll_one+100, line_num*14) line_num=line_num+1
end
function r_gen_background(a, rand_race)
	bg = "You are a"..race_if_an(a)..".  One of the "..playable_race_names[rand_race][2]
	return bg
end
function randomize_actor(a)
	local sylables = math.random(1,3)
	local rand_race = math.random(1,table.getn(playable_race_names))
	a.name = crude_names_front[math.random(1,table.getn(crude_names_front))]
	for x=1, sylables do
		a.name = a.name..crude_names_back[math.random(1,table.getn(crude_names_back))]
	end
	
	a.a_type = playable_race_names[rand_race][1]
	a.strength = math.random(1,5)
	a.agility = math.random(1,5)
	a.intel   = math.random(1,5)
	a.stamina = math.random(1,5)
	a.luck    = math.random(1,5)
	a.sex     = math.random(0,1)
	a.background = r_gen_background(a, rand_race) -- generate a random background.
	return a
end

function update_actor_chargen(a, key, mouse_B, mouse_x, mouse_y) --updates based on mouse/key press
	if key == "r" then
		randomize_actor(a)
	end
end

function create_actor(game, level,chargen) --create a random actor
	if chargen == false then
		a = {
			name = "random",
			a_type = "human",
			sex = math.random(0,1), --0 female, 1 male
			strength = 1,
			agility =  1,
			intel   =  1,
			stamina =  1,
			luck    =  1,
			background = "None"
		}
		if level > 1 then
			for x = 1, level do
				a.strength = math.random(0,3)
				a.agility =  math.random(0,3)
				a.intel   =  math.random(0,3)
				a.stamina =  math.random(0,3)
				a.luck    =  math.random(0,3)
				end
		else -- chargen
			game.mode = 100
		end--endelse
	end--endif
	return a --return the actor to the "pointer" hehe.
end

function draw_chargen(actor) --stock actor has been generated
	draw_border(255,255,255,255)--require("primatives")
	display_actor_stats(actor, false)--false, not editable, true, editable
end

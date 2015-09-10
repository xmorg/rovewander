--chargen_stat_selector = " "

playable_race_names = {	{"Human", "short-lived hardworking folk of the midland kingdoms", "a"}, --one of the 
	{"HalfElf", "humans who can trace their bloodlines to an elven heritage.", "b"},
	{"Norlander",  "tall humans who live in the frozen wastes of the north.", "c"},
	{"Nomad",  "mix of tribal humans who wander the lands and trade horses and livestock.", "d"},
	{"Elf",  "fair folk, who have made their home in the midland.", "e"},
	{"Dark Elf",  "dread ones, or the Rock Elves.  The Dark Elves live deep in the earth and often clash with dwarves.", "f"},
	{"High Elf",  "kingdom Elves, who live in the Elven Kingdoms of the mystic Isles.", "g"},
	{"Gnome", "elusive advanced race of mechanical geniuses.", "h"},
	{"Dwarf",  "short stout humanoids who live in the mountains and build great holds out of soid rock.", "i"},
	{"Abyss Dwarf", "redskinned dwarves are known for delving deeply and creating mythical lava forges.", "j"}, 
	{"Topside Dwarf",  "Dwarves who have built great kingdoms in the earth, and often merge with human kingdoms.", "l"},
	{"Wild Elf",  "wild Elves live in the great forrests of the midlands, and the northern snowpines.", "m"},
	{"Goblin", "small devious creatures, which live almost everyhwere and bother almost everyone.", "n"},
	{"Orc",  "large race of barbaric humanoids who look like giant furry goblins.", "o"},
	{"Trorc",  "halftroll who are a hybrid creature, created by dark experiments.  They are few in number but large, strong and violent.", "p"},
	{"Owlman",  "reclusive winged humanoids, who inhabid the winded craigs of the southland.", "q"},
	{"Catman",  "feline humanoids who live the deep forests that blur the lines between men and beast. Catmen are wise fast, and furry.", "r"},
	{"Ratigan",  "race of ratmen, not to be confused with the were-rat.   Ratigans, were once as numerous as goblins, but now live in caves.", "s"},
	{"Mermen", "mythical aquatic peoples that rule the sea as men rule the land.  They are in constant war with the Naga.", "t"},
	{"Harepon",  "feral birdmen which live on remote islands and are a constant nuisance to shipping.", "u"},
	{"Locustin",  "lords of the the crop wasters, are giant locust-man.  Many years ago the midland kings pushed their kind far to the east.", "v"},
	{"Lizardman",  "scaled ones, are an ancient race, which once ruled the midland. Their numbers declined for an unknown reason, and they remain in the western isles.", "w"},
	{"Naga", "a vicious races of snakemen, often called mersnakes.  They have a dubious alliance with the Lizardmen.", "x"}
}	

function get_agro_by_race(player, npc)
	
end

crude_names_front = {"Al", "Bre", "Cel", "Dan", "Ed", "Ford", "Guy", "Haus", "Ister",
	"Jim", "Kael", "Liam", "Mor", "Nast", "Oh", "Pel", "Qin", "Ray", "Sten","Tell",
	"Urst", "Val", "Wist", "Xen", "Yor", "Zum"
}
crude_names_back = {"ane", "eber", "ic", "od", "ue", "af", "eg", "him", "oi",
	"aj", "ek", "ille", "om", "un", "ao", "ep", "quipp", "or", "us","at",
	"eur", "iv", "ow", "ux", "ay", "ez"
}
strength_background_text = {"You have suffered with ill health all of your life.",
	"You were weaker than most your age growing up.", "You are an average build.",
	"Through hard work as a child, you have become strong.",
	"Your father was warrior and trained you as a child."
}
agility_background_text = {"A childhood injury has made you slow.",
	"You were clumbsy growing up.", "You made your way through life putting one foot in front of the other.",
	"Your friends often referred to you as the monkey",
	"Your catlike reflexes has often saved your life as a child."
}
intel_background_text = {"You were often shunned for being simple minded.", 
	"You had difficulty concentrating as a child.", 
	"You are of average intelect but barely educated.", 
	"You were a bright child, and caught up quickly with your studies.", 
	"You often amazed your trainers with your brilliance."
}
stamina_background_text = {"You were frail and sickly all of your life.", 
	"You are smaller than most of your peers, and often get sick", 
	"You have known sicknes and health but have overcome.", 
	"You have made it though the great plagues as a child, because of your great constitution.", 
	"You ran for miles as child and barely got winded."
}
charisma_background_text = {
		"After the death of your parents you fell into deep depression. You feel as if you can trust no one.",
		"You are often moody and difficult to socialize with",
		"You get along with others, but some just tolorate you",
		"You were often the life of the party, and many speak well of you",
		"Your silver tongue, has often gotten you what you want in life."
} 
luck_background_text = {
		"You seemed to be cursed, and nothing you do ever seems to prosper.",
		"You are generally considered unlucky.",
		"You are not superstitious, and have had many sucesses and just as many failures.",
		"You were often considered lucky.",
		"Even in the most hopeless situations you seemed to come out on top."
}
--if 10 and lower
past_occupationsh = {"Warrior", "Baker", "Thief", "Pirate", "Farmer", "Nomad",
"Peasant", "Noble", "Priest", "Courtier", "Librarian", "Mage", "Shipwright",
"Mason", "Hunter", "Shepherd", "Savant"
}
--If > 11
past_occupationsf = {"Warrior", "Scavenger", "Raider", "Warlord", "Thief",
	"Nomad","Shaman", "Wanderer"}
random_life_event = {"Your village was destroyed by a dragon.", 
	"Your parents died when you were young.",
	"You never knew your father.", 
	"You once made a name for yourself hawking local merchandise.",
	"You were separated from your family after a raider attack.", 
	"A tense meeting with a bear as a child made you evaluate your life goals.",
	"You were raised by monks", "When you were young you had a pet rat."}
require("primatives")

math.randomseed(os.time())

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

function display_playable_races() --playable_race_names(23)
   local line_num = 20
   local coll_one = 20
   local coll_two = 250
   --{"HalfElf", "humans who can trace their bloodlines to an elven heritage."}
   --for i, v in ipairs(a) do
   --print(i, v)
   --end
   function next_col(ind)
      if ind > 12 then
	 return 200
      else
	 return 0
      end
   end
   function next_line(ind)
      if ind > 12 then
	 return ind -12
      else return ind
      end
   end
   love.graphics.setColor(255,255,255,255)
   for i,v in ipairs(playable_race_names) do
      love.graphics.print(playable_race_names[i][3]..") "..playable_race_names[i][1], 
			  coll_one+50+next_col(i), line_num*next_line(i) ) -- print the names
   end
   
end

function draw_race_selector()
   draw_border(255,255,255,255)--require("primatives")
   display_playable_races()
end
function display_actor_stats(actor, editing)--actor object, boolean viewable
   local line_num = 3
   local coll_one = 20
   local coll_two = 250
   
   love.graphics.setColor(255,255,255,255)
   love.graphics.print("(N)ame: ".. actor.name, coll_one, line_num*14)
   love.graphics.print("Race: ".. actor.a_type, coll_two, line_num*14) 
   love.graphics.print("Sex(m/f): "..sex_if_an(actor), coll_two+200, line_num*14) line_num=line_num+1
   love.graphics.print("============================================================", coll_one, line_num*14)line_num=line_num+1
   
   love.graphics.printf(actor.background, coll_two, line_num*14, 350, "left")
   
   love.graphics.print(point_at_current_stat(5).." (S)trength :", coll_one, line_num*14) 
   love.graphics.print( actor.strength.." (-/+)", coll_one+120, line_num*14) line_num=line_num+1
   love.graphics.print(point_at_current_stat(6).." (A)gility :", coll_one, line_num*14) 
   love.graphics.print(actor.agility.." (-/+)",coll_one+120, line_num*14) line_num=line_num+1
   love.graphics.print(point_at_current_stat(7).." (I)ntelligence:", coll_one, line_num*14)
   love.graphics.print( actor.intel.." (-/+)",coll_one+120, line_num*14) line_num=line_num+1
   love.graphics.print(point_at_current_stat(8).." S(t)amina:", coll_one, line_num*14)
   love.graphics.print( actor.stamina.." (-/+)", coll_one+120, line_num*14) line_num=line_num+1
   love.graphics.print(point_at_current_stat(10).." (C)harisma:", coll_one, line_num*14)
   love.graphics.print( actor.charisma.." (-/+)", coll_one+120, line_num*14) line_num=line_num+1
   love.graphics.print(point_at_current_stat(9).." (L)uck:", coll_one, line_num*14)
   love.graphics.print( actor.luck.." (-/+)", coll_one+120, line_num*14) line_num=line_num+1
   if game.mode == "chargen" then
      love.graphics.print("X Bonus Points: "..actor.bonus_points, coll_one, line_num*15)
   end
   love.graphics.print("============================================================", coll_one, line_num*25)
   
end

function r_gen_background(a, rand_race)
   bg = "You are a"..race_if_an(a)..".  One of the "..playable_race_names[rand_race][2]
      .. " ".. strength_background_text[a.strength].. " "..agility_background_text[a.agility]
      .. " ".. intel_background_text[a.intel].. " "..stamina_background_text[a.stamina]
      .. " ".. charisma_background_text[a.charisma].. " "..luck_background_text[a.luck]
      .. " ".. random_life_event[math.random(1,table.getn(random_life_event))]
      .. " Your father was a "..past_occupationsh[math.random(1,table.getn(past_occupationsh))]
      .. ". Your mother was a "..past_occupationsh[math.random(1,table.getn(past_occupationsh))]
      .. "."
   return bg
end
function update_init_maxhealth(a)
   max_health = math.floor( (a.strength+a.stamina)/2+a.stamina)
   h = max_health
   return h
end
function randomize_actor(a, race)
   local sylables = math.random(1,3)
   local rand_race = math.random(1,table.getn(playable_race_names))
   a.name = crude_names_front[math.random(1,table.getn(crude_names_front))]
   for x=1, sylables do
      a.name = a.name..crude_names_back[math.random(1,table.getn(crude_names_back))]
   end
   if race==nil then
      a.a_type = playable_race_names[rand_race][1]
   else
      a.a_type = race
   end
   a.strength = math.random(1,5)
   a.agility = math.random(1,5)
   a.intel   = math.random(1,5)
   a.stamina = math.random(1,5)
   a.luck    = math.random(1,5)
   a.charisma = math.random(1,5)
   a.sex     = math.random(0,1)
   --a.max_health = math.floor( (a.strength+a.stamina)/2+a.stamina)
   --a.health = a.max_health
   a.max_health = update_init_maxhealth(a)
   a.health = update_init_maxhealth(a)
   a.background = r_gen_background(a, rand_race) -- generate a random background.
   a.inventory = {}
   a.bonus_points = 0
   a.facing = "north"
   a.movestatus = "finished" --finished(dont move again)/ready(set premove)
   a.playeragro = 0 -- player agro
   table.insert(a.inventory,new_starting_weapon(7) )
   table.insert(a.inventory,new_starting_armor(3) )
   table.insert(a.inventory,new_starting_helm(3) )
   return a
end
function point_at_current_stat(s)
   if s == a.current_stat then return "[*]"
   else return "[ ]" end
end

function update_race_chargen(player, key)
   --for i,v in ipairs(playable_race_names) do
   --   love.graphics.print(playable_race_names[i][3]..") "..playable_race_names[i][1], 
   --			  coll_one+50+next_col(i), line_num*next_line(i) ) -- print the names
   --end
   for i,v in ipairs(playable_race_names) do
      if key == playable_race_names[i][3] then
	 a.a_type = playable_race_names[i][1]
	 a.background = r_gen_background(a, i)
	 game.mode = "chargen"
      end
   end
end

function update_actor_chargen(a, key, mouse_B, mouse_x, mouse_y) --updates based on mouse/key press
   if key == "d" then  --randomize actor
      randomize_actor(a, nil)
      a.edited = 1
   elseif key == "n" and a.editing_name == 0 then --set editing name flag
      a.editing_name = 1
      a.name = ""
   elseif (key == "enter" or key == "return") and a.editing_name == 1 then
      a.editing_name = 0
   elseif key == "p" and a.editing_name == 0 and game.mode == "chargen" then
      --randomize stats.
      randomize_actor(a, nill)
   elseif key == "g" and a.editing_name == 0 and game.mode == "chargen" then
      --ARE YOU SURE?
      a.max_health = update_init_maxhealth(a)
      a.health = update_init_maxhealth(a)
      game.mode = "message box"
      player.edited = 1
      --save player data
      love.filesystem.write( "player.lua", table.show(player, "player")) 
      game.mode = "message box" --97      
   elseif key == "f" and a.editing_name == 0 then
      a.sex = 0
   elseif key == "m" and a.editing_name == 0 and game.mode == "chargen" then
      a.sex = 1
   elseif key == "s" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 5 --strength = 1, --5
   elseif key == "a" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 6 --agility =  1, --6
   elseif key == "i" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 7 --intel   =  1, --7
   elseif key == "t" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 8 --stamina =  1, --8
   elseif key == "l" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 9 --luck    =  1, --9
   elseif key == "c" and a.editing_name == 0 and game.mode == "chargen"  then
      a.current_stat = 10  --charisma = 1, --10
   elseif key == "r" and a.editing_name == 0 and game.mode == "chargen"  then
      game.mode = "chargen_race_selector"
   elseif key == "-" and a.editing_name == 0 and game.mode == "chargen"  then
      if a.current_stat == 5 then
	 if a.strength > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.strength = a.strength -1
	 end
	 a.max_health = update_init_maxhealth(a)
	 a.health = update_init_maxhealth(a)
      elseif a.current_stat == 6 then
	 if a.agility > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.agility = a.agility -1
	 end
      elseif a.current_stat == 7 then
	 if a.intel > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.intel = a.intel -1
	 end
      elseif a.current_stat == 8 then
	 if a.stamina > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.stamina = a.stamina -1
	 end
	 a.max_health = update_init_maxhealth(a)
	 a.health = update_init_maxhealth(a)
      elseif a.current_stat == 10 then
	 if a.luck > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.luck = a.luck -1
	 end
      elseif a.current_stat == 9 then
	 if a.charisma > 1 then
	    a.bonus_points = a.bonus_points+1
	    a.charisma = a.charisma -1
	 end
      end
   elseif (key == "=" or key == "+") and a.editing_name == 0 and game.mode == "chargen"  then
      if a.bonus_points > 0 then
	 if a.current_stat == 5 then
	    a.bonus_points = a.bonus_points-1
	    a.strength = a.strength +1
	    a.max_health = update_init_maxhealth(a)
	    a.health = update_init_maxhealth(a)
	 elseif a.current_stat == 6 then
	    a.bonus_points = a.bonus_points-1
	    a.agility = a.agility +1
	 elseif a.current_stat == 7 then
	    a.bonus_points = a.bonus_points-1
	    a.intel = a.intel +1
	 elseif a.current_stat == 8 then
	    a.bonus_points = a.bonus_points-1
	    a.stamina = a.stamina +1
	    a.max_health = update_init_maxhealth(a)
	    a.health = update_init_maxhealth(a)
	 elseif a.current_stat == 9 then
	    a.bonus_points = a.bonus_points-1
	    a.luck = a.luck +1
	 elseif a.current_stat == 10 then
	    a.bonus_points = a.bonus_points-1
	    a.charisma = a.charisma +1
	 end
      end
   elseif a.editing_name == 1 then
      if key ~= "rshift" and key ~= "lshift" then
	 if key=="backspace" then
	    a.name=a.name
	 else
	    if string.len(a.name) == 0 then
	       a.name=a.name..string.upper(key)
	    else
	       a.name=a.name..key
	    end
	 end--not backspace
      end--if not shift
   end--endif
end

function create_actor(game, level,chargen) --create a random actor
   a = {
      name = "random",
      a_type = "human",
      level = 0,
      sex = math.random(0,1), --0 female, 1 male
      strength = 1, --5
      agility =  1, --6
      intel   =  1, --7
      stamina =  1, --8
      luck    =  1, --9
      charisma = 1, --10
      health = 1,
      maxhealth = 1,
      background = "None",
      editing_name = 0, -- are we typing his name?
      edited       = 0, -- have we rolled yet?
      current_stat = 5,  -- selected stat to edit.
      bonus_points = 10,
      max_stat = 6,
      loc_x = 0,
      loc_y = 0,
      playeragro = 0
   }
   if chargen == false then --randomize the actor
      a = randomize_actor(a, nil)
   else -- chargen == true
      game.mode = "chargen" --100
   end--endif
   return a --return the actor to the "pointer" hehe.
end

function draw_char_info(actor)
   draw_border(255,255,255,255)--require("primatives")
   display_actor_stats(actor, false)--false, not editable, true, editable
end

function draw_chargen(actor) --stock actor has been generated
   instruction_line = love.graphics.getHeight()-40
   draw_border(255,255,255,255)--require("primatives")
   display_actor_stats(actor, false)--false, not editable, true, editable
   love.graphics.print("Type 'n' for name, m/f to change sex, and r to change race.",
		       20, instruction_line -60)
   love.graphics.print("Type 's/a/i/t/l/c' to select stat to edit, and +/- to modify it",
		       20, instruction_line -40)
   love.graphics.print("Type 'p' to randomize stats, press (enter) to enter a customer name.",
		       20, instruction_line -20)
   love.graphics.print("Type 'g' when ready to start the game! Be sure to distribute all points.",
		       20, instruction_line -0)
end

function create_actor_list(town_name, race)
	local population = 0
   	local race_rand
   	population = math.random(5,25)
   	actor_list = {}
   	for x=1, population do
		a = create_actor(game, 1, false)
      	if race == "Watertype" then
			race_rand = math.random(1,3)
			if race_rand == 1 then
				a = randomize_actor(a, "Mermen")
			elseif race_rand == 2 then
				a = randomize_actor(a, "Lizardman")
			elseif race_rand == 3 then
				a = randomize_actor(a, "Naga")
      		end
		elseif race == "Lower Undeadtype" then
			race_rand = math.random(1,3)
			if race_rand == 1 then
				a = randomize_actor(a, "Skeleton")
				a.playeragro = 100
			elseif race_rand == 2 then
				a = randomize_actor(a, "Ghoul")
				a.playeragro = 100
			elseif race_rand == 3 then
				a = randomize_actor(a, "Zombie")
				a.playeragro = 100
			end
		elseif race == "Lower Orctype" then
			race_rand = math.random(1,3)
			if race_rand == 1 then
				a = randomize_actor(a, "Goblin")
				--run agro by list.
			elseif race_rand == 2 then
				a = randomize_actor(a, "Orc")
			elseif race_rand == 3 then
				a = randomize_actor(a, "Trorc")
			end
		elseif race == "Lower Abysstype" then
			race_rand = math.random(1,3)
			if race_rand == 1 then
				a = randomize_actor(a, "Goblin")
			elseif race_rand == 2 then
				a = randomize_actor(a, "Abyss Dwarf")
			elseif race_rand == 3 then
				a = randomize_actor(a, "Dark Elf")
			end
		elseif race == "Lower Beasttype" then
			race_rand = math.random(1,3)
			if race_rand == 1 then
				a = randomize_actor(a, "Ratigan")
			elseif race_rand == 2 then
				a = randomize_actor(a, "Owlman")
			elseif race_rand == 3 then
				a = randomize_actor(a, "Catman")
			end
		else
			a = randomize_actor(a, race)
		end
		a.loc_x = math.random(5, game.tilecount-5)
		a.loc_y = math.random(5, game.tilecount-5)
		table.insert(actor_list, a)
	end  --save the file, townname_script.lua	
   love.filesystem.write( town_name.."_script.lua", table.show(actor_list, "actor_list"))--save worldmap
   return actor_list
end

function load_actor_to_map(actor_list)
   --go through a list and put '@' in
   --note this function assumes that that the tilecount is not less that actor locations if so
   --then index out of range errors will occour
   npc_map = {}
   for y=1, game.tilecount do
      x_temp_map = {}
      table.insert(npc_map, x_temp_map)
      for x=1, game.tilecount  do
	 table.insert(npc_map[y], 0)
      end
   end
   for i,v in ipairs(actor_list) do
      npc_map[actor_list[i].loc_y][actor_list[i].loc_x] = actor_list[i]
   end
end

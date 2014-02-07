--world for worldmap


inn_nouns = {"Giant", "Muskrat", "Rat", "Dog", "Raven", "Bear", "Knight", "Pirate", "Mustache"}
inn_adj   = {"Prancing", "Red", "Black", "Brave", "Bold", "Cowardly"}
inn_origin_messages1 = {"After a long days travel you have finally arrived at",
	"The last thing you remember is booking a room at",
	"The night was chilly so you stopped to warm your feet at",
	"Upon arriving into townt the locals directed you to"
}
dungeon_origin_message1 = { "For mocking a nobles son you were banished to",
	"After being kidnapped by bandits you were taken to",
	"You have been imprissoned for a horrible crime you did not commit.  You overheard the guards say your dungeon was in",
	"You joined an expidition team to explore",
	"You awake in",
	"After your wagon train was attacked by mauraders you ran for your life and hid in",
}
town_prefix = {"Up", "Green", "Red", "Smith", "Dark", "River", "Hill", "Ox",
"Hart", "Mass", "Non","Knight","Kings","Dukes","Beggars"
}
town_suffix = {"wich", "ford", "herd", "son", "river","ton", "towne", "gail", "wark", "ham",
	"worth","haven","drownings","side","mission"
}
dungeon_suffix = {"Barrow", "Dungeon", "Castle", "Fort", "Warrens", "Labarynth", "Dirge", "Catacombs", "Coven", "Maze", "Cove"}
dungeon_prefix = {"Ruins of", "Graves of", "Dispicable place of", "Cursed mound of"}
town_ext_suffix = {"Court", "Vale", "Commons", "Ford", "Crossing", "Mesa", "Redding", "Dwellings", "City"}

function get_town_name()
	add_ext = math.random(1,2)
	town_name = town_prefix[math.random(1,table.getn(town_prefix))]
		..town_suffix[math.random(1,table.getn(town_suffix))]
	if add_ext == 1 then
		town_name = town_name .. " " .. town_ext_suffix[math.random(1,table.getn(town_ext_suffix))]
	end
	return town_name
end
function get_dungeon_name()
	d_name = ""
	add_pref = math.random(1,3)
	if add_pref == 1 then
		d_name = d_name.."The ".. dungeon_prefix[math.random(1,table.getn(dungeon_prefix))].." "
	end
	d_name = d_name..get_town_name().." ".. dungeon_suffix[math.random(1,table.getn(dungeon_suffix))]
	return d_name
end
function get_inn_name()
	use_adj = math.random(1,2)
	if use_adj == 1 then
		inn_name = "The "..inn_adj[math.random(1, table.getn(inn_adj))]
			.." "..inn_nouns[math.random(1, table.getn(inn_nouns))]
	else
		inn_name = "The "..inn_nouns[math.random(1, table.getn(inn_adj))]
			.." and the "..inn_nouns[math.random(1, table.getn(inn_nouns))]
	end
	return inn_name
end
function load_newzone(direction, x, y)
	if direction == "north" then
		if y-1 > 1 and worldmap[y-1][x] == "X" then
			generate_random_zone(x, y-1) --create a new map
		end
	elseif direction == "east" then
		if x+1 < table.getn(worldmap)-1 and worldmap[y][x+1] == "X" then
			generate_random_zone(x+1, y) --create a new map
		end
	elseif direction == "south" then
		if y+1 <table.getn(worldmap)-1  and worldmap[y+1][x] == "X" then
			generate_random_zone(x, y+1) --create a new map
		end
	elseif direction == "west" then
		if x-1 > 1 and worldmap[y][x-1] == "X" then
			generate_random_zone(x-1, y) --create a new map
		end
	end
end
function draw_worldmap()
	dx = 20
	dy = 20
	draw_border(255,255,255,255)--require("primatives")
	love.graphics.setColor(255,255,255,255)
	for y=1, 12 do
		for x=1,12 do
			love.graphics.print(worldmap[y][x],x*8 +dx, y*14+dy)
		end
	end
end

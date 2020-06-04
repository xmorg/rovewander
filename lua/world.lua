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
	"worth","haven","drownings","side","mission", "wood", "rock", "snow"
}
forest_suffix = {"Vale", "Forest", "Woods", "Wood", "Glenn", "Furrows", "Tree", "Woodlands"}
dungeon_suffix = {"Barrow", "Dungeon", "Castle", "Fort", "Warrens", "Labarynth", 
	"Depths", "Dirge", "Catacombs", "Coven", "Maze", "Cove"}
dungeon_prefix = {"Ruins of", "Graves of", "Dispicable place of", 
	"Depths of", "Fortress of", "Cursed mound of"}
town_ext_suffix = {"Court", "Vale", "Commons", "Ford", "Crossing", "Mesa", "Redding", "Dwellings", "City"}


function table.show(t, name, indent)
   local cart     -- a container
   local autoref  -- for self references
   local function isemptytable(t) return next(t) == nil end

   local function basicSerialize (o)
      local so = tostring(o)
      if type(o) == "function" then
         local info = debug.getinfo(o, "S")
         -- info.name is nil because o is not a calling level
         if info.what == "C" then
            return string.format("%q", so .. ", C function")
         else 
            -- the information is defined through lines
            return string.format("%q", so .. ", defined in (" ..
                info.linedefined .. "-" .. info.lastlinedefined ..
                ")" .. info.source)
         end
      elseif type(o) == "number" or type(o) == "boolean" then
         return so
      else
         return string.format("%q", so)
      end
   end

   local function addtocart (value, name, indent, saved, field)
      indent = indent or ""
      saved = saved or {}
      field = field or name

      cart = cart .. indent .. field

      if type(value) ~= "table" then
         cart = cart .. " = " .. basicSerialize(value) .. ";\n"
      else
         if saved[value] then
            cart = cart .. " = {}; -- " .. saved[value] 
                        .. " (self reference)\n"
            autoref = autoref ..  name .. " = " .. saved[value] .. ";\n"
         else
            saved[value] = name
            --if tablecount(value) == 0 then
            if isemptytable(value) then
               cart = cart .. " = {};\n"
            else
               cart = cart .. " = {\n"
               for k, v in pairs(value) do
                  k = basicSerialize(k)
                  local fname = string.format("%s[%s]", name, k)
                  field = string.format("[%s]", k)
                  -- three spaces between levels
                  addtocart(v, fname, indent .. "   ", saved, field)
               end
               cart = cart .. indent .. "};\n"
            end
         end
      end
   end

   name = name or "__unnamed__"
   if type(t) ~= "table" then
      return name .. " = " .. basicSerialize(t)
   end
   cart, autoref = "", ""
   addtocart(t, name, indent)
   return cart .. autoref
end

function love_crude_save()
	love.filesystem.write( "worldmap.lua", table.show(worldmap, "worldmap")) 
end
function love_save_zone(name)
	love.filesystem.write( name..".lua", table.show(game_map, "game_map"))
end
function new_world_map(size)
	worldmap = {}
	for y=1, size do
		local temp_table = {}
		table.insert(worldmap, temp_table)
		for x=1, size do
			local ttable={"X", "", ""}
			--prototype local ttable={"X", {"Name", "Lore"}, {"Name", "Lore"}}
			table.insert(worldmap[y],ttable)
		end
	end
end

function get_town_name()
	add_ext = math.random(1,2)
	town_name = town_prefix[math.random(1,table.getn(town_prefix))]
		..town_suffix[math.random(1,table.getn(town_suffix))]
	if add_ext == 1 then
		town_name = town_name .. " " .. town_ext_suffix[math.random(1,table.getn(town_ext_suffix))]
	end
	return town_name
end
function get_forest_name()
	findex = math.random(1, table.getn(forest_suffix))
	f = get_town_name() .. " " .. forest_suffix[findex]
	return f
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
	--Needs to be a way to compare the current zone with the new to be created.
	if direction == "north" then
		if y-1 > 1 and worldmap[y-1][x][1] == "X" then
			generate_random_zone(x, y-1) --create a new map
		else
			chunk = love.filesystem.load( worldmap[y-1][x][2]..".lua" )
			chunk()
		end
	elseif direction == "east" then
		if x+1 < table.getn(worldmap)-1 and worldmap[y][x+1][1] == "X" then
			generate_random_zone(x+1, y) --create a new map
		else
			chunk = love.filesystem.load( worldmap[y][x+1][2]..".lua" )
			chunk()
		end
	elseif direction == "south" then
		if y+1 < table.getn(worldmap)-1  and worldmap[y+1][x][1] == "X" then
			generate_random_zone(x, y+1) --create a new map
		else
			chunk = love.filesystem.load( worldmap[y+1][x][2]..".lua" )
			chunk()
		end
	elseif direction == "west" then
		if x-1 > 1 and worldmap[y][x-1][1] == "X" then
			generate_random_zone(x-1, y) --create a new map
		else
			chunk = love.filesystem.load( worldmap[y][x-1][2]..".lua" )
			chunk()
		end
	end
end
function draw_worldmap()
	dx = 20
	dy = 20
	draw_border(255,255,255,255)--require("primatives")
	love.graphics.setColor(255,255,255,255)
	for y=1, 11 do
		for x=1,11 do
			--prototype t = worldmap[y][x][1][1]
			t = worldmap[y][x][1]
			if t == "f" then love.graphics.setColor(0,200,0,255) --forest
			elseif t == "t" then love.graphics.setColor(200,200,0,255) --town?
			elseif t == "d" then love.graphics.setColor(200,0,0,255) --dungeon
			elseif t == "~" then love.graphics.setColor(0,0,255,255) --water
			elseif t == "i" then love.graphics.setColor(200,200,0,255) --inn
			elseif t == "D" then love.graphics.setColor(200,200,0,255) --dwarf hold
			elseif t == "X" then love.graphics.setColor(0,0,0,255) 
			end
			--love.filesystem.write( "whatsthat.lua", table.show(t, "t")) 
			love.graphics.print(t,x*8 +dx, y*14+dy)
		end
	end
	love.graphics.print(worldmap[game.player_world_y][game.player_world_x][2], 400, 100)
end

function generate_random_zone(x,y)
   start_loc = math.random(1,6)
   wm_start = table.getn(worldmap)/2
   if start_loc == 1 then --Inn
      create_inn_map(game.tilecount)
      worldmap[y][x][1] = "i"
      worldmap[y][x][2] = get_inn_name()
      game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
      load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Humantype"))
   elseif start_loc == 2 then --Forest
      create_forest_map(math.random(1,10))
      worldmap[y][x][1] = "f"
      worldmap[y][x][2] = get_forest_name()
      game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
      local forestype = math.random(1,4)
      if forestype == 1 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
      elseif forestype == 2 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Elftype"))
      elseif forestype == 3 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Beasttype"))
      elseif forestype == 4 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Orctype"))
      end
   elseif start_loc == 3 then --dungeon
      create_dungeon_topside()
      worldmap[y][x][1] = "d"
      worldmap[y][x][2] = get_dungeon_name()
      game.current_message = dungeon_origin_message1[math.random(1,table.getn(dungeon_origin_message1))].. " " ..worldmap[y][x][2]
      local dungeontype = math.random(1,3)
      if dungeontype == 1 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
      elseif dungeontype == 2 then
			load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Orctype"))
      elseif dungeontype == 3 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Undeadtype"))
      end
   elseif start_loc == 4 then --town
      create_town_map()
      worldmap[y][x][1] = "t"
      worldmap[y][x][2] = get_town_name()
      game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
      local towntype = math.random(1,2)
      if towntype == 1 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
      elseif towntype == 2 then
	 load_actor_to_map(create_actor_list(worldmap[y][x][2], "Lower Human")) -- all human types
      end
   elseif start_loc == 5 then --water
      shore_dir = math.random(1,7) --1 north, 2 east 3 south 4 west 5 none, 6 middle, 7
      create_sea_map(shore_dir) --- put direction
      worldmap[y][x][1] = "~"
      worldmap[y][x][2] = get_town_name()
      game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
      load_actor_to_map(create_actor_list(worldmap[y][x][2], "Watertype"))
   elseif start_loc == 6 then -- Dward Hold
      shore_dir = math.random(1,7) --1 north, 2 east 3 south 4 west 5 none, 6 middle, 7
      create_dwarfhold_map(shore_dir) --- put direction
      worldmap[y][x][1] = "D"
      worldmap[y][x][2] = get_town_name()
      --do dwarfhold message
      game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
      load_actor_to_map(create_actor_list(worldmap[y][x][2], "Dwarf"))
   end
   --love_crude_save()
   love_save_zone(worldmap[y][x][2])
end
function love.load()
   love.window.setFullscreen(true)
   love.graphics.setNewFont(game.fsize)
   new_world_map(12) --creates new world map
   wm_start = table.getn(worldmap)/2
   generate_random_zone(wm_start, wm_start)
   game.player_world_x = wm_start --start loc on world map
   game.player_world_y = wm_start
   player = create_actor(game, 1, true)
   love.keyboard.setKeyRepeat(true)
end

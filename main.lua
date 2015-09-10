game = { 
	mode = "chargen",
	tilecount = 30, 
	drawcount = 50,
	draw_x = 80, --where to start drawing the map
	draw_y = 40,
	player_loc_x = 15,
	player_loc_y = 15,
	look_x = player_loc_x,
	look_y = player_loc_y,
	player_world_x = 0,
	player_world_y = 0,
	default_collision = "attack",
	current_event = "none",
	current_message = "Sample Message",
	time_day=0, time_hour=6, time_minute=0
}

game_map = {}
obj_map = {}
worldmap = {}
fogofwar = {}
npc_map = {}

require("actor")
require("primatives")
require("world")
require("message")
require("items")
require("interact")
require("controls")
require("render")

math.randomseed(os.time())

player = create_actor(game, 1, false)
player_inventory = {}

function increase_gametime() --time_day=0, time_hour=0, time_minute=0
	game.time_minute = game.time_minute+1
	if game.time_minute >= 60 then
		game.time_minute=0
		game.time_hour= game.time_hour+1
		if game.time_hour >=24 then
			game.time_hour=0
			game.time_day=game.time_day+1
		end
	end
end
function is_night() --checks to see if its day or night.
	if game.time_hour >= 21 and game.time_hour <= 4 then
		return true
	else 
		return false
	end
end
function generate_random_zone(x,y)
	start_loc = math.random(1,5)
	wm_start = table.getn(worldmap)/2
	if start_loc == 1 then
		create_inn_map(game.tilecount)
		worldmap[y][x][1] = "i"
		worldmap[y][x][2] = get_inn_name()
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
		load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
	elseif start_loc == 2 then
		create_forest_map(math.random(1,10))
		worldmap[y][x][1] = "f"
		worldmap[y][x][2] = get_forest_name()
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
		load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
	elseif start_loc == 3 then
		create_dungeon_topside()
		worldmap[y][x][1] = "d"
		worldmap[y][x][2] = get_dungeon_name()
		game.current_message = dungeon_origin_message1[math.random(1,table.getn(dungeon_origin_message1))].. " " ..worldmap[y][x][2]
		load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
	elseif start_loc == 4 then
		create_town_map()
		worldmap[y][x][1] = "t"
		worldmap[y][x][2] = get_town_name()
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
		load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
	elseif start_loc == 5 then
		shore_dir = math.random(1,7) --1 north, 2 east 3 south 4 west 5 none, 6 middle, 7
		create_sea_map(shore_dir) --- put direction
		worldmap[y][x][1] = "~"
		worldmap[y][x][2] = get_town_name()
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..worldmap[y][x][2]
		load_actor_to_map(create_actor_list(worldmap[y][x][2], "Human"))
	end
	--love_crude_save()
	love_save_zone(worldmap[y][x][2])
end
function love.load()
	new_world_map(12) --creates new world map
	wm_start = table.getn(worldmap)/2
	generate_random_zone(wm_start, wm_start)
	game.player_world_x = wm_start --start loc on world map
	game.player_world_y = wm_start
	player = create_actor(game, 1, true)
end

function love.mousepressed(x, y, button)
   if button == "l" then --left button?
      if game.mode == "chargen" then
	 if player.edited == 1 then
	    --save player data
	    love.filesystem.write( "player.lua", table.show(player, "player")) 
	    game.mode = "message box" --97
	 end
      elseif game.mode == "message box" then --97
	 game.mode = "ingame"
      end
      if x >=0 and x <=100 and y >= love.graphics.getHeight()/10 
      and y <= love.graphics.getHeight()/10*9 then
	 game.player_loc_x = game.player_loc_x -1
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth() 
	 and y >= love.graphics.getHeight()/10 
      and y <= love.graphics.getHeight()/10*9 then
	 game.player_loc_x = game.player_loc_x +1
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 
      and y >= 0 and y <= 100 then
	 game.player_loc_y = game.player_loc_y -1
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 
      and y <= love.graphics.getHeight() and y >= love.graphics.getHeight()/10*9 then
	 game.player_loc_y = game.player_loc_y +1
      end--endif
   end--endif
end

function npc_actions() --current event.
	local move_rand = math.random(0, 4) -- 0none,1north,2east,3south,4west
	for y=1,game.tilecount do
		for x=1,game.tilecount do
			if npc_map[y][x] ~= 0 then
				npc_map[y][x].movestatus = "ready"
			end
		end
	end
	if game.current_event == "player move" then
		for y=1, game.tilecount do
			for x=1, game.tilecount do
				if npc_map[y][x] ~= 0 then --move NPC
					if move_rand == 1 and get_any_obstacle(y-1,x) == 0 and npc_map[y][x].movestatus == "ready" then --north
						--move NPC
						npc_map[y-1][x] = npc_map[y][x] --moved
						npc_map[y][x] = 0 --filed vacume
						npc_map[y][x].movestatus = "finished"
					elseif move_rand == 2 and get_any_obstacle(y,x+1) == 0 and npc_map[y][x].movestatus == "ready" then --east
						--move NPC
						npc_map[y][x+1] = npc_map[y][x] --moved
						npc_map[y][x] = 0 --filed vacume
						npc_map[y][x].movestatus = "finished"
					elseif move_rand == 3 and get_any_obstacle(y+1,x) == 0 and npc_map[y][x].movestatus == "ready" then --south
						--move NPC
						npc_map[y+1][x] = npc_map[y][x] --moved
						npc_map[y][x] = 0 --filed vacume
						npc_map[y][x].movestatus = "finished"
					elseif move_rand == 4 and get_any_obstacle(y,x-1) == 0 and npc_map[y][x].movestatus == "ready" then --approved to move
						--move NPC
						npc_map[y][x-1] = npc_map[y][x] --moved
						npc_map[y][x] = 0 --filed vacume
						npc_map[y][x].movestatus = "finished"
					end
				end
			end
		end
	end --endif
end --end function
function update_process_events() --process events.
	if game.current_event == "player move" then
		--npc_map[actor_list[i].loc_y][actor_list[i].loc_x] = actor_list[i]
		--npc's should move sometimes
		npc_actions() --do it
		game.current_event = "none" -- ok we get it
	elseif game.current_event == "player steal" then
		--woa! pickpockets!
		game.current_event = "none" -- ok we get it
	elseif game.current_event == "player attack" then
		--combat happens!
		game.current_event = "none" -- ok we get it
	end
end
function love.update()
   local barrier_y = 0
   local barrior_x = 0
   local fnight = 0
   if is_night() == true then
      fnight = 0
   else
      fnight = 10
   end
   for y= -5-fnight, 5+fnight do
      for x= -5-fnight,5+fnight do
	 if game.player_loc_y+y > 0 and game.player_loc_x+x > 0 
	    and game.player_loc_y+y < game.tilecount+1 
	 and game.player_loc_x+x < game.tilecount+1 then
	    --if game_map[game.player_loc_y+y][game.player_loc_x+x]
	    --can currently see through walls :(
	    --what about daytime?
	    fogofwar[game.player_loc_y+y][game.player_loc_x+x] = 1
	 end
      end
   end
   update_process_events() --process events.
   player.loc_y = game.player_loc_y
   player.loc_x = game.player_loc_x
end

function setcolorbyChar(char)
	if char=="," then
		return 0,200,0,255
	elseif char=="t" then
		return 0,255,0,255
	elseif char=="l" then
		return 80,80,0,255
	elseif char=="~" then
		return 0,0,math.random(240,255),255
	elseif char=="." then
		return 100, 80, 15,255
	elseif char=="Y" then
		return 255, 255, 0, 255
	elseif char=="=" then
		return 100, 100, 15,255
	elseif char==">" or char=="<" then
		return 255, 255, 255, 255
	elseif char=="#" then
		return 70,70,70,255
	elseif char=="+" then
		return 60,60,60,255
	else
		return 255,0,0,255
	end
end


function love.draw()
   if game.mode == "ingame" then --game
      love.draw_cam_viewable()
   elseif game.mode == "chargen" then --chargen 100
      draw_chargen(player)
   elseif game.mode == "chargen_race_selector" then --update_race_chargen()
      draw_race_selector()
   elseif game.mode == "character sheet" then  --character status
      draw_char_info(player)
   elseif game.mode == "world map" then --world map
      draw_worldmap()
   elseif game.mode == "message box" then --message box 97
      love.draw_cam_viewable()
      draw_messagebox()
   elseif game.mode == "inventory sheet" then --inventory 96
      draw_inventory()
   elseif game.mode == "look mode" then --look mode 95
      love.draw_cam_viewable()
      --love.graphics.print("_", x*8-4+dx,y*14+dy )
   end
end

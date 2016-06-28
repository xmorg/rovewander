--controls

function update_talk_mode(player,key)
	if key == "f" then game.mode = "ingame" end
end

function look_mode(key, isrepeat )
   local px = game.player_loc_x
   local py = game.player_loc_y
   local dy = game.draw_y
   local dx = game.draw_x
   if key == "escape" then
      game.mode = "ingame"
   elseif key == "o" then
      game.mode = "ingame"
   elseif key == "return" or key == "space" then
      game.mode = "ingame" -- activate the default_collision
   elseif (key == "right" or key == "l") then 
      game.look_x = game.look_x +1
   elseif (key == "left" or key == "h") then 
      game.look_x = game.look_x -1
   elseif (key == "up" or key == "k")  then
      game.look_y = game.look_y -1
   elseif (key == "down" or key == "j") then
      game.look_y = game.look_y +1
   end
end

function ingame_mode( key, isrepeat )
   local px = game.player_loc_x
   local py = game.player_loc_y
   local dy = game.draw_y
   local dx = game.draw_x
   if key == "escape" then
      love.event.quit()
   elseif key == "f1" then 
      if game.default_collision == "attack" then game.default_collision = "look"
      elseif game.default_collision == "look" then game.default_collision = "talk"
      elseif game.default_collision == "talk" then game.default_collision = "steal"
      elseif game.default_collision == "steal" then game.default_collision = "attack"
      end
   elseif key == "q" then
      --cant quaff yet!
      game.current_message = "Can't Quaff yet!"
      game.mode = "ingame"
   elseif key == "C" and game.mode == "ingame" then
      chunk = love.filesystem.load( "game.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( "player.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( "worldmap.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
      --chunk = love.filesystem.load( worldmap[y-1][x][2]..".lua" )
      chunk()
   elseif key == "o" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "look"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "t" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "talk"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "a" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "attack"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "S" then
      --save game(assume zone files are already saved
      love.filesystem.write( "game.lua", table.show(game, "game")) --save game
      love.filesystem.write( "player.lua", table.show(player, "player")) --save player
      love.filesystem.write( "worldmap.lua", table.show(worldmap, "worldmap"))--save worldmap
   elseif key == "w" then
	 game.mode = "world map"
   elseif key == "i" then 
      game.mode = "inventory sheet"
   elseif key == "c" then
      game.mode = "character sheet"
   elseif (key == "." or key == ">") and game.mode == "ingame" then
      if worldmap[game.player_world_y][game.player_world_x][1] == "d" then
	 if worldmap[game.player_world_y][game.player_world_x][3] == "" then
	    create_dungeon_map(100)
	    game_map[game.player_loc_y][game.player_loc_y] = "<"
	 else
	    chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][3].." Lv1"..".lua")
	    chunk()
	 end				
      end
   elseif (key == "," or key == "<") and game.mode == "ingame" then
      if worldmap[game.player_world_y][game.player_world_x][2] == "" then
	 --create_dungeon_map(100)
	 game_map[game.player_loc_y][game.player_loc_y] = "<"
      else
	 chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
	 chunk()
      end
   elseif (key == "left" or key == "h") and game.mode == "ingame" then
      player.facing = "west"
      if game_map[py][px-1] == "D" then
	 load_newzone("west", game.player_world_x, game.player_world_y)
	 game.player_world_x = game.player_world_x-1
	 game.player_loc_x = table.getn(game_map)-2
	 game.draw_x = game.draw_x- (table.getn(game_map)-2)*8
	 increase_gametime()
      end
      if px > 2 and get_any_obstacle(py, px-1)== 0 then
	 if npc_map[py][px-1] ~= 0 then
	 end
	 game.player_loc_x = game.player_loc_x -1
	 game.draw_x=game.draw_x+1*8
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py, px-1) == 1 then
	    on_interact(player, py, px-1)
	 end
      end	   
   elseif (key == "right" or key == "l") and game.mode == "ingame" then
      player.facing = "east"
      if game_map[py][px+1] == "D" then
	 load_newzone("east", game.player_world_x, game.player_world_y)
	 game.player_world_x = game.player_world_x+1
	 game.player_loc_x = 2
	 game.draw_x = game.draw_x+ (table.getn(game_map)-2)*8
	 increase_gametime()
      end
      if  get_any_obstacle(py,px+1) == 0 then
	 game.player_loc_x = game.player_loc_x +1
	 game.draw_x=game.draw_x-1*8
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py, px+1) == 1 then
	    on_interact(player, py, px+1)
	 end
      end
   elseif (key == "up" or key == "k") then
      player.facing = "north"
      if game_map[py-1][px] == "D" then
	 load_newzone("north", game.player_world_x, game.player_world_y)
	 game.player_world_y = game.player_world_y-1
	 game.player_loc_y = table.getn(game_map)-2
	 game.draw_y = game.draw_y- (table.getn(game_map)-2)*14
	 increase_gametime()
      end
      if py > 2 and get_any_obstacle(py-1,px) == 0 then
	 game.player_loc_y = game.player_loc_y -1
	 game.draw_y=game.draw_y+1*14
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py-1, px) == 1 then
	    --interact
	    on_interact(player, py-1, px)
	 end
      end
   elseif (key == "down" or key == "j") and game.mode == "ingame" then
      player.facing = "south"
      if game_map[py+1][px] == "D" then
	 load_newzone("south", game.player_world_x, game.player_world_y)
	 game.player_world_y = game.player_world_y+1
	 game.player_loc_y = 2
	 game.draw_y = game.draw_y + (table.getn(game_map)-2)*14
	 increase_gametime()
      end
      if get_any_obstacle(py+1,px) == 0 then --game.draw_y = game.draw_y -1
	 game.player_loc_y = game.player_loc_y +1
	 game.draw_y=game.draw_y-1*14
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py+1, px) == 1 then
	    --interact
	    on_interact(player, py+1, px)
	 end
      end
   end-- end if's	 
end -- end function ingame


function love.keypressed( key, isrepeat )
   if game.mode == "chargen" then
      update_actor_chargen(player, key, nil, nil, nil)
   elseif game.mode == "chargen_race_selector" then
      update_race_chargen(player, key, nil, nil, nil)
   elseif game.mode == "message box" then --""message box""
      if key == "retern" or key == "o" or key == "space" or key == "space" then
	 game.mode = "ingame"
      end
   elseif game.mode == "choice message box" then
      if key == "y" then
      	game.lastchoice = "yes"
      	game.mode = "ingame"
      elseif key == "n" then
      	game.lastchoice = "no"
      	game.mode = "ingame"
      end -- set a var in game.
   elseif game.mode == "talk" then
      update_talk_mode(player,key,nil, nil, nil)
   elseif game.mode == "look mode" then ------- LOOK MODE ------------------
      look_mode(key, isrepeat)
   elseif game.mode == "ingame" then  ------- IN GAME ----------------------
      ingame_mode( key, isrepeat )
   elseif game.mode == "world map" then --world map mode
      if key == "w" or key == "escape" then
	 game.mode = "ingame"
      end
   elseif game.mode == "character sheet" then
      if key == "c" then
	 game.mode = "ingame"
      end
   elseif game.mode == "inventory sheet" then
      if key == "i" then
	 game.mode = "ingame"
      end
   end--endif key
end--endfunction

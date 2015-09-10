--controls

function love.keypressed( key, isrepeat )
	local px = game.player_loc_x
	local py = game.player_loc_y
	local dy = game.draw_y
	local dx = game.draw_x
	if game.mode == "chargen" then
		update_actor_chargen(player, key, nil, nil, nil) 
	elseif game.mode == "chargen_race_selector" then
	   update_race_chargen(player, key, nil, nil, nil)
	end
	if key == "escape" then
		if game.mode == "look mode" then
			game.mode == "ingame"
		--elseif game.mode == 95 then
		--	game.mode = 1
		else
			love.event.quit()
		end
	elseif key == "f1" then 
		if game.default_collision == "attack" then game.default_collision = "look"
		elseif game.default_collision == "look" then game.default_collision = "talk"
		elseif game.default_collision == "talk" then game.default_collision = "steal"
		elseif game.default_collision == "steal" then game.default_collision = "attack"
		end
	elseif key == "q" then
		--cant quaff yet!
		game.current_message = "Can't Quaff yet!"
		game.mode = 97
	elseif key == "l" and game.mode == "ingame" then
		chunk = love.filesystem.load( "game.lua" )
		chunk()--bug check for these files first!
		chunk = love.filesystem.load( "player.lua" )
		chunk()--bug check for these files first!
		chunk = love.filesystem.load( "worldmap.lua" )
		chunk()--bug check for these files first!
		chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
		--chunk = love.filesystem.load( worldmap[y-1][x][2]..".lua" )
		chunk()
	elseif key == "k" and game.mode == "ingame" then
		game.mode = "look mode" -- look mode
		game.look_x = game.player_loc_x
		game.look_y = game.player_loc_y
	elseif key == "s" and game.mode == "ingame" then
		--save game(assume zone files are already saved
		love.filesystem.write( "game.lua", table.show(game, "game")) --save game
		love.filesystem.write( "player.lua", table.show(player, "player")) --save player
		love.filesystem.write( "worldmap.lua", table.show(worldmap, "worldmap"))--save worldmap
	elseif key == "w" then
		if game.mode == "world map" then
			game.mode = "ingame"
		else game.mode = "world map" end --world map mode
	elseif key == "c" then
		if game.mode == "character sheet" then
			game.mode = "ingame"
		else
			if game.mode == "ingame" then
				game.mode = "character sheet" 
			end --character sheet mode
		end
	elseif key == "i" and game.mode == "ingame" then 
			game.mode = "inventory sheet"
	elseif key == "i" and game.mode == "inventory sheet" then
			game.mode = "ingame"
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
	elseif key == "left" and game.mode == "look mode" then game.look_x = game.look_x -1
	elseif key == "left" and game.mode == "ingame" then
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
			increase_gametime()
		end
	elseif key == "right" and game.mode == "look mode" then game.look_x = game.look_x +1
	elseif key == "right" and game.mode == "ingame" then
			if game_map[py][px+1] == "D" then
				load_newzone("east", game.player_world_x, game.player_world_y)
				game.player_world_x = game.player_world_x+1
				game.player_loc_x = 2
				game.draw_x = game.draw_x+ (table.getn(game_map)-2)*8
				increase_gametime()
			end
			if get_any_obstacle(py,px+1) == 0 then
				game.player_loc_x = game.player_loc_x +1
				game.draw_x=game.draw_x-1*8
				increase_gametime()
			end
	elseif key == "up" and game.mode == "look mode" then game.look_y = game.look_y -1
	elseif key == "up" and game.mode == "ingame" then
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
			increase_gametime()
		end
	elseif key == "down" and game.mode == "look mode" then game.look_y = game.look_y +1
	elseif key == "down" and game.mode == "ingame" then
		if game_map[py+1][px] == "D" then
			load_newzone("south", game.player_world_x, game.player_world_y)
			game.player_world_y = game.player_world_y+1
			game.player_loc_y = 2
			game.draw_y = game.draw_y + (table.getn(game_map)-2)*14
			increase_gametime()
		end
		if get_any_obstacle(py+1,px) == 0 then
			--game.draw_y = game.draw_y -1
			game.player_loc_y = game.player_loc_y +1
			game.draw_y=game.draw_y-1*14
			increase_gametime()
		end
	end--endif key
end--endfunction

game = { 
	mode = 1,
	tilecount = 30, 
	drawcount = 50,
	draw_x = 80, --where to start drawing the map
	draw_y = 40,
	player_loc_x = 15,
	player_loc_y = 15,
	player_world_x = 0,
	player_world_y = 0,
	current_message = "Sample Message"
}

game_map = {}
obj_map = {}
worldmap = {
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"},
	{"X","X","X","X","X","X","X","X","X","X","X","X"}
}

require("actor")
require("primatives")
require("world")
require("message")

math.randomseed(os.time())

player = create_actor(game, 1, false)



function generate_random_zone(x,y)
	start_loc = math.random(1,4)
	wm_start = table.getn(worldmap)/2
	if start_loc == 1 then
		create_inn_map(game.tilecount)
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..get_inn_name()
		worldmap[y][x] = "i"
	elseif start_loc == 2 then
		create_forest_map(math.random(1,10))
		worldmap[y][x] = "f"
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..get_town_name()
	elseif start_loc == 3 then
		--create_dungeon_map(100)
		create_dungeon_topside()
		worldmap[y][x] = "d"
		game.current_message = dungeon_origin_message1[math.random(1,table.getn(dungeon_origin_message1))].. " " ..get_dungeon_name()
	elseif start_loc == 4 then
		create_town_map()
		worldmap[y][x] = "t"
		game.current_message = inn_origin_messages1[math.random(1,table.getn(inn_origin_messages1))].. " " ..get_town_name()
	end
end
function love.load()
	wm_start = table.getn(worldmap)/2
	generate_random_zone(wm_start, wm_start)
	game.player_world_x = wm_start --start loc on world map
	game.player_world_y = wm_start
	player = create_actor(game, 1, true)
end

function love.mousepressed(x, y, button)
	if button == "l" then
		if game.mode == 100 then
			if player.edited == 1 then
				game.mode = 97
			end
		elseif game.mode == 97 then
			game.mode = 1
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
function love.keypressed( key, isrepeat )
	local px = game.player_loc_x
	local py = game.player_loc_y
	local dy = game.draw_y
	local dx = game.draw_x
	if game.mode == 100 then
		update_actor_chargen(player, key, nil, nil, nil) 
	end
	if key == "escape" then
		love.event.quit()
	elseif key == "w" then
		if game.mode == 98 then
			game.mode = 1
		else game.mode = 98 end
	elseif key == "c" then
		if game.mode == 99 then
			game.mode = 1
		else game.mode = 99 end
	elseif key == "." or key == ">" then
		if worldmap[game.player_world_y][game.player_world_x] == "d" then
			create_dungeon_map(100)
			game_map[game.player_loc_y][game.player_loc_y] = "<"
		end
	elseif key == "," or key == "<" then
		if worldmap[game.player_world_y][game.player_world_x] == "d" then
			--find the saved map for that world. (you need to save it first!)
		end
	elseif key == "left" then
		if game_map[py][px-1] == "D" then
			load_newzone("west", game.player_world_x, game.player_world_y)
			game.player_world_x = game.player_world_x-1
			game.player_loc_x = table.getn(game_map)-2
			game.draw_x = game.draw_x- (table.getn(game_map)-2)*8
		end
		if px > 2 and game_map[py][px-1] ~= "t" and game_map[py][px-1] ~= "#" and game_map[py][px-1] ~= "l" then
			game.player_loc_x = game.player_loc_x -1
			game.draw_x=game.draw_x+1*8
		end
	elseif key == "right" then
		if game_map[py][px+1] == "D" then
			load_newzone("east", game.player_world_x, game.player_world_y)
			game.player_world_x = game.player_world_x+1
			game.player_loc_x = 2
			game.draw_x = game.draw_x+ (table.getn(game_map)-2)*8
		end
		if game_map[py][px+1] ~= "t" and game_map[py][px+1] ~= "#" and game_map[py][px+1] ~= "l" then
			game.player_loc_x = game.player_loc_x +1
			game.draw_x=game.draw_x-1*8
		end
	elseif key == "up" then
		if game_map[py-1][px] == "D" then
			load_newzone("north", game.player_world_x, game.player_world_y)
			game.player_world_y = game.player_world_y-1
			game.player_loc_y = table.getn(game_map)-2
			game.draw_y = game.draw_y- (table.getn(game_map)-2)*14
		end
		if py > 2 and game_map[py-1][px] ~= "t" and game_map[py-1][px] ~= "#" and game_map[py-1][px] ~= "l" then
			game.player_loc_y = game.player_loc_y -1
			game.draw_y=game.draw_y+1*14
		end
	elseif key == "down" then
		if game_map[py+1][px] == "D" then
			load_newzone("south", game.player_world_x, game.player_world_y)
			game.player_world_y = game.player_world_y+1
			game.player_loc_y = 2
			game.draw_y = game.draw_y + (table.getn(game_map)-2)*14
		end
		if game_map[py+1][px] ~= "t" and game_map[py+1][px] ~= "#"  and game_map[py+1][px] ~= "l" then
			--game.draw_y = game.draw_y -1
			game.player_loc_y = game.player_loc_y +1
			game.draw_y=game.draw_y-1*14
		end
	end
	
end
function love.update()
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

function love.draw_cam_viewable()
	local px = game.player_loc_x
	local py = game.player_loc_y
	local dy = game.draw_y
	local dx = game.draw_x
	local draw_center_x = love.graphics.getWidth()/2
	local draw_center_y = love.graphics.getHeight()/2

	sx = px*8
	sy = py*14
	for y=1 , game.tilecount do --50
		for x=1 , game.tilecount do --50
			love.graphics.setColor(setcolorbyChar(game_map[y][x]))
			if y == game.player_loc_y and x == game.player_loc_x then
				love.graphics.setColor(255,255,255,255)
				love.graphics.print("@", x*8-4+dx,y*14+dy )
			--elseif x*8 <= 16 and y*14 <= 28 then
			--	t = 0
			elseif game_map[y][x] == "#" then
				love.graphics.setColor(setcolorbyChar(game_map[y][x]))
				love.graphics.rectangle("fill", x*8+dx, y*14+dy, 8, 14)
			else
				love.graphics.print(game_map[y][x],x*8 +dx, y*14+dy)
			end
		end
	end
	draw_border(200,200,200,255)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(player.name..": "..player.health.."("..player.max_health..")", 10,14)
	love.graphics.print(px.."X"..py..game_map[py][px], 742,14)
end
function love.draw()
	if game.mode == 1 then --game
		love.draw_cam_viewable()
	elseif game.mode == 100 then --chargen
		draw_chargen(player)
	elseif game.mode == 99 then
		draw_char_info(player)
	elseif game.mode == 98 then
		draw_worldmap()
	elseif game.mode == 97 then
		love.draw_cam_viewable()
		draw_messagebox()
	end
end

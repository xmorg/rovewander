game = { 
	mode = 1,
	tilecount = 30, 
	drawcount = 50,
	draw_x = 80, --where to start drawing the map
	draw_y = 40,
	player_loc_x = 15,
	player_loc_y = 15
}

game_map = {}
obj_map = {}


require("actor")
require("primatives")

math.randomseed(os.time())

player = create_actor(game, 1, false)




function love.load()
	--create_inn_map(game.tilecount)
	--create_forest_map()
	--create_inn_map()-- = create_inn_items()
	--create_dungeon_map(100)
	create_town_map()
	player = create_actor(game, 1, true)
end

function love.mousepressed(x, y, button)
	if button == "l" then
		if game.mode == 100 then
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
	elseif key == "c" then
		if game.mode == 99 then
			game.mode = 1
		else game.mode = 99 end
	elseif key == "left" then
		if px > 2 and game_map[py][px-1] ~= "t" and game_map[py][px-1] ~= "#" then
			game.player_loc_x = game.player_loc_x -1
			game.draw_x=game.draw_x+1*8
		end
	elseif key == "right" then
		if game_map[py][px+1] ~= "t" and game_map[py][px+1] ~= "#" then
			game.player_loc_x = game.player_loc_x +1
			game.draw_x=game.draw_x-1*8
		end
	elseif key == "up" then
		if py > 2 and game_map[py-1][px] ~= "t" and game_map[py-1][px] ~= "#" then
			game.player_loc_y = game.player_loc_y -1
			game.draw_y=game.draw_y+1*14
		end
	elseif key == "down" then
		if game_map[py+1][px] ~= "t" and game_map[py+1][px] ~= "#" then
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
	elseif char=="." then
		return 100, 80, 15,255
	elseif char=="=" then
		return 100, 100, 15,255
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
	end
end

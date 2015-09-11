--file
function show_steal_msg()
end
function show_attack_msg()
end
function show_look_data(mchar, x, y)
	px = 100
	py = 600-28
	lstr = ""
	love.graphics.setColor(255,255,255,255)
	if npc_map[y][x] ~= 0 then
		if npc_map[y][x].name ~= nil then
			lstr = lstr..npc_map[y][x].name.. " the ".. npc_map[y][x].a_type
		else
			lstr = lstr.."a person "
		end
	end
	if mchar == "#" then
		lstr = lstr.." a wall"
	elseif mchar == "~" then
		lstr = lstr.." water"
	elseif mchar == "+" then
		lstr = lstr.." Stone floor"
	elseif mchar == "t" then
		lstr = lstr.." a tree"
	elseif mchar == "," then
		lstr = lstr.." Grass"
	elseif mchar == "." then
		lstr = lstr.." Dirt"
	else
		lstr = lstr.." nothing"
	end
	love.graphics.print(lstr, px, py)
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
	 if fogofwar[y][x] == 0 then
	    love.graphics.setColor(0,0,0,140)
	 else
	    love.graphics.setColor(setcolorbyChar(game_map[y][x]))
	 end
	 if y == game.player_loc_y and x == game.player_loc_x then
	    love.graphics.setColor(255,255,255,255)
	    love.graphics.print("@", x*8-4+dx,y*14+dy )
	    --elseif x*8 <= 16 and y*14 <= 28 then
	    --	t = 0
	 elseif game_map[y][x] == "#" then
	    love.graphics.setColor(setcolorbyChar(game_map[y][x]))
	    love.graphics.rectangle("fill", x*8+dx, y*14+dy, 8, 14)
	 elseif npc_map[y][x] ~= 0 and fogofwar[y][x] ~= 0 then
	    love.graphics.setColor(190,190,255,255)
	    love.graphics.print("@", x*8-4+dx,y*14+dy )
	 else
	    love.graphics.print(game_map[y][x],x*8 +dx, y*14+dy)
	 end
	 if game.mode == "ingame" and game.default_collision == "look" then
	 	on_get_obstacle_look(player)
	 end
	 if game.mode == "look mode" and y == game.look_y and x == game.look_x then --lookmode
	    --love.graphics.print("_", x*8-4+dx,y*14+dy )
	    love.graphics.print("_", game.look_x*8-4+dx,game.look_y*14+dy )
	    --print what you see
	    show_look_data(game_map[y][x], x, y)
	 end
      end
   end
   draw_border(200,200,200,255)
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.print(player.name..": "..player.health.."("
			  ..player.max_health..")  ["..game.default_collision.."]", 10,14)
   love.graphics.print("facing: "..player.facing.." Time: ".. game.time_day..":"..game.time_hour..":"..game.time_minute.. "   " ..px.."X"..py..game_map[py][px], 642,14)
   --time_day=0, time_hour=0, time_minute=0
end

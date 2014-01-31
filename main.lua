game = { 
	mode = 1,
	tilecount = 80, 
	drawcount = 50,
	draw_x = 0, --starts drawing at 0,0
	draw_y = 0,
	player_loc_x = 40,
	player_loc_y = 20
}
temp_map = {}
obj_map = {}
player = nil

require("actor")

function love.load()
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(temp_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount *2 do
			table.insert(temp_map[y], ",")
			tree_rand = math.random(1,100)
			if tree_rand == 1 then
				table.insert(temp_map[y], "t")
			elseif tree_rand >= 2 and tree_rand <= 20 then
				table.insert(temp_map[y], ".")
			else
				table.insert(temp_map[y], ",")
			end
		end--endfor x
	end--endfor y
	temp_map[32][20] = "#" temp_map[32][21] = "#"
	temp_map[32][22] = "#" temp_map[32][23] = "#"
	player = create_actor(game, 1, true)
end

function love.mousepressed(x, y, button)
	if button == "l" then
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
	
	if key == "escape" then
		love.event.quit()
	elseif key == "left" then
		if px > 3 and temp_map[py][px-1] ~= "t" and temp_map[py][px-1] ~= "#" then
			game.player_loc_x = game.player_loc_x -1
		end
	elseif key == "right" then
		if temp_map[py][px+1] ~= "t" and temp_map[py][px+1] ~= "#" then
			game.player_loc_x = game.player_loc_x +1
		end
	elseif key == "up" then
		if py > 3 and temp_map[py-1][px] ~= "t" and temp_map[py-1][px] ~= "#" then
			game.player_loc_y = game.player_loc_y -1
		end
	elseif key == "down" then
		if temp_map[py+1][px] ~= "t" and temp_map[py+1][px] ~= "#" then
			--game.draw_y = game.draw_y -1
			game.player_loc_y = game.player_loc_y +1
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
	elseif char=="#" then
		return 70,70,70,255
	else
		return 255,0,0,255
	end
end
function love.draw_border()
	characters_x = love.graphics.getWidth() / 8
	characters_y = love.graphics.getHeight()/ 14
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("+", 0, 0)
	love.graphics.print("+", love.graphics.getWidth()-8, 0)
	love.graphics.print("+", 0, love.graphics.getHeight()-14)
	
	for y=1, characters_y do
		love.graphics.print("|", 0,y*14)
		love.graphics.print("|", love.graphics.getWidth()-8, y*14)
	end
	for x=1, characters_x do
		love.graphics.print("-", x*8,0)
		love.graphics.print("-", x*8,love.graphics.getHeight()-14)
		love.graphics.print("-", x*8, 28)
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
	for y=1 , game.drawcount do --50
		for x=1 , game.drawcount*2 do --50
			love.graphics.setColor(setcolorbyChar(temp_map[y][x]))
			if y == game.player_loc_y and x == game.player_loc_x then
				love.graphics.setColor(255,255,255,255)
				love.graphics.print("@", x*8-4+dx,y*14+dy )
			elseif x*8 <= 16 and y*14 <= 28 then
				t = 0
			elseif temp_map[y][x] == "#" then
				love.graphics.setColor(setcolorbyChar(temp_map[y][x]))
				love.graphics.rectangle("fill", x*8+dx, y*14+dy, 8, 14)
			else
				love.graphics.print(temp_map[y][x],x*8 +dx, y*14+dy)
			end
		end
	end
	--love.graphics.setColor(255,255,255,255)
	--love.graphics.print("@", draw_center_x-4,draw_center_y-7 )
	love.draw_border()
	love.graphics.print(temp_map[py][px]..py+dy.."X"..px+dx, 10,10)
end
function love.draw()
	if game.mode == 1 then --game
		love.draw_cam_viewable()
	elseif game.mode == 100 then --chargen
		draw_chargen(0)
	end
end

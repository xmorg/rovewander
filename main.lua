game = { 
	tilecount = 80, 
	drawcount = 50,
	draw_x = 1, --starts drawing at 0,0
	draw_y = 1,
	loc_x,
	loc_y
}
temp_map = {}
obj_map = {}

function love.load()
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(temp_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount do
			table.insert(temp_map[y], ",")
			tree_rand = math.random(1,100)
			if tree_rand == 1 then
				table.insert(temp_map[y], "t")
			else
				table.insert(temp_map[y], ",")
			end
		end
	end
end

function love.mousepressed(x, y, button)
	if button == "l" then
		if x >=0 and x <=100 and y >= love.graphics.getHeight()/10 
			and y <= love.graphics.getHeight()/10*9 then
			game.draw_x = game.draw_x +1
		elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth() 
			and y >= love.graphics.getHeight()/10 
			and y <= love.graphics.getHeight()/10*9 then
			game.draw_x = game.draw_x -1
		elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 
			and y >= 0 and y <= 100 then
			game.draw_y = game.draw_y +1
		elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 
			and y <= love.graphics.getHeight() and y >= love.graphics.getHeight()/10*9 then
			game.draw_y = game.draw_y -1
		end--endif
	end--endif
end
function love.keypressed( key, isrepeat )
	if key == "escape" then
		love.event.quit()
	elseif key == "left" then
		game.draw_x = game.draw_x +1
	elseif key == "right" then
		game.draw_x = game.draw_x -1
	elseif key == "up" then
		game.draw_y = game.draw_y +1
	elseif key == "down" then
		game.draw_y = game.draw_y -1
	end
	
end
function love.update()
end

function setcolorbyChar(char)
	if char=="," then
		return 0,200,0,255
	elseif char=="t" then
		return 0,255,0,255
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
function love.draw_cam_viewable(lx,ly)
	local draw_center_x = love.graphics.getWidth()/2
	local draw_center_y = love.graphics.getHeight()/2

	for y=1 , game.drawcount do --50
		for x=1 , game.drawcount do --50
			if lx*x > 1 and lx*x < game.tilecount and ly*y > 1 and ly*y < game.tilecount then
				love.graphics.setColor(setcolorbyChar(temp_map[y][x]))
				love.graphics.print(temp_map[y*ly][x*lx],x*8,y*14)
			end
			--love.draw_map_by_char()
			--love.graphics.setColor(setcolorbyChar(temp_map[y][x]))
			--love.graphics.print(temp_map[y][x],x*8+game.draw_x*8,y*14+game.draw_y*14)
		end
	end
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("@", draw_center_x-4,draw_center_y-7 )
	love.draw_border()
end
function love.draw()
	love.draw_cam_viewable(game.draw_x, game.draw_y)
end

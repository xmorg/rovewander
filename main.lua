game = { 
	tilecount = 80, 
	draw_x = love.graphics.getWidth()/2 / 8 - 1, --starts drawing at 0,0
	draw_y = love.graphics.getHeight()/2 / 14 -2
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

function love.draw_cam_viewable(actor)
	local draw_center_x = love.graphics.getWidth()/2
	local draw_center_y = love.graphics.getHeight()/2

	for y=1 , game.tilecount do
		for x=1 , game.tilecount do
			love.graphics.setColor(setcolorbyChar(temp_map[y][x]))
			love.graphics.print(temp_map[y][x],x*8+game.draw_x*8,y*14+game.draw_y*14)
		end
	end
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(actor, draw_center_x-4,draw_center_y-7 )
end
function love.draw()
	love.draw_cam_viewable("@")
end

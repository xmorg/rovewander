function draw_border(r, g, b, a)
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), 14) --top
	love.graphics.rectangle("fill", 0,0, 8, love.graphics.getHeight() ) --left side
	love.graphics.rectangle("fill", 0,love.graphics.getHeight()-14, love.graphics.getWidth(), 14) --bottom
	love.graphics.rectangle("fill", love.graphics.getWidth()-8,0, 8, love.graphics.getHeight() )--right side
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 8,14, love.graphics.getWidth() -16, 20)
end
function create_ran_map(game)
	temp_map = {}
	obj_map  = {}
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
	return x_temp_map, x_obj_map
end
function create_inn_map()
	temp_map = {}
	for y=1, 50 do
		x_temp_map = {}
		table.insert(temp_map, x_temp_map)
		for x=1, 50 do
			if y==1 then
				table.insert(temp_map[y], "#")
			elseif x==1 then
				table.insert(temp_map[y], "#")
			elseif y==50 then
				table.insert(temp_map[y], "#")
			elseif x==50 then
				table.insert(temp_map[y], "#")
			else
				table.insert(temp_map[y], "=")
			end--endif
		end--endfor
	end--endfor
	return temp_map
end

function create_inn_items()
	temp_map = {}
	for y=1, 50 do
		x_temp_map = {}
		table.insert(temp_map, x_temp_map)
		for x=1, 50 do
			if y==1 then
				table.insert(temp_map[y], "#")
			elseif x==1 then
				table.insert(temp_map[y], "#")
			elseif y==50 then
				table.insert(temp_map[y], "#")
			elseif x==50 then
				table.insert(temp_map[y], "#")
			else
				table.insert(temp_map[y], "=")
			end--endif
		end--endfor
	end--endfor
	return temp_map
end


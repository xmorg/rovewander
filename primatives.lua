function draw_border(r, g, b, a)
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), 14) --top
	love.graphics.rectangle("fill", 0,0, 8, love.graphics.getHeight() ) --left side
	love.graphics.rectangle("fill", 0,love.graphics.getHeight()-14, love.graphics.getWidth(), 14) --bottom
	love.graphics.rectangle("fill", love.graphics.getWidth()-8,0, 8, love.graphics.getHeight() )--right side
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 8,14, love.graphics.getWidth() -16, 20)
end

function draw_table(gmap, chairs, x,y)
	--=h=
	--hOh
	--=h=
	gmap[y][x+1] = "h"
	gmap[y+1][x]  = "h"
	gmap[y+1][x+1] = "O"
	gmap[y+1][x+2] = "h"
	gmap[y+2][x+1] = "h"
end

function create_inn_map()
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(game_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount  do
			if x > 1 and x < game.tilecount and y > 1 and y < game.tilecount then
				table.insert(game_map[y], "=")
			elseif x == game.tilecount/2 and y == 1 then
				table.insert(game_map[y], "D")
			else
				table.insert(game_map[y], "#")
			end--endif
		end--endfor x
	end--endfor
	draw_table(game_map, 4, 5,5)
end

function put_dungeon_wall(vh, loc)
	if vh == 1 then --vert
		for y=1, game.tilecount do
			trand=math.random(1,10)
			if trand ~=1 then
				game_map[y][loc] = "#"
			end
		end
	else --2        --horiz
		for x=1, game.tilecount do
			trand=math.random(1,8)
			if trand ~=1 then
				game_map[loc][x] = "#"
			end
		end
	end
end
function create_dungeon_map(size)
	game.tilecount = size
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(game_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount  do
			if x > 1 and x < game.tilecount and y > 1 and y < game.tilecount then
				table.insert(game_map[y], "+")
			elseif x == game.tilecount/2 and y == 1 then
				table.insert(game_map[y], "D")
			else
				table.insert(game_map[y], "#")
			end--endif
		end--endfor x
	end--endfor
	for y=1, 18 do
		put_dungeon_wall(math.random(1,2), math.random(2,game.tilecount))
	end
end

function create_forest_map()
	game.tilecount = 100
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(game_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount  do
			treerand = math.random(1,20)
			if treerand == 1 then
				game_map[y][x] = "t"
			elseif x > 1 and x < game.tilecount and y > 1 and y < game.tilecount then
				table.insert(game_map[y], ",")
			elseif x == game.tilecount/2 and y == 1 then
				table.insert(game_map[y], "D")
			else
				table.insert(game_map[y], "t")
			end--endif
		end--endfor x
	end--endfor
end

function place_building(btype, bsize, lx, ly)
	for y=1, bsize do
		for x=1, bsize do
			game_map[ly+y][lx+x]= "#"
		end
	end
	
	for y=2, bsize-1 do
		for x=2, bsize-1 do
			game_map[ly+y][lx+x]= "+"
		end
	end
end

function create_town_map()
	game.tilecount = 100
	for y=1, game.tilecount do
		x_temp_map = {}
		x_obj_map = {}
		table.insert(game_map, x_temp_map)
		table.insert(obj_map, x_obj_map)
		for x=1, game.tilecount  do
			--treerand = math.random(1,20)
			--if treerand == 1 then
			--	game_map[y][x] = "t"
			if x > 1 and x < game.tilecount and y > 1 and y < game.tilecount then
				table.insert(game_map[y], ",")
			elseif x == game.tilecount/2 and y == 1 then
				table.insert(game_map[y], "D")
			else
				table.insert(game_map[y], "#")
			end--endif
		end--endfor x
	end--endfor
	buildingcount = math.random(3, 20)
	for x=1,buildingcount do
		place_building(0, math.random(5,10), math.random(3, game.tilecount-11), math.random(3, game.tilecount-11))
	end
end



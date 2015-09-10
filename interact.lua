--interact .lua, talk, look, etc

function on_get_obstacle_look() -- see what is blocking your path
  if player.facing == "north" then
    show_look_data(game_map[y-1][x], x, y-1)
  elseif player.facing == "east" then
    show_look_data(game_map[y][x+1], x+1, y)
  elseif player.facing == "south" then
    show_look_data(game_map[y+1][x], x, y+1)
  elseif player.facing == "west" then
    show_look_data(game_map[y][x-1], x-1, y)
end
  
function get_ncpmap_obstacle(y,x) --check if npc_map returned an obstacle
  if npc_map[y][x] ~= 0 then 
    return 1
  else 
    return 0
  end
end

function get_obstacle(y,x) --test weather character is an obstacle
  if game_map[y][x] == "#" then 
    return 1
  elseif game_map[y][x] == "t" then 
    return 1
  elseif game_map[y][x] == "l" then 
    return 1
  else 
    return 0
  end
end

function get_any_obstacle(y,x)
  if get_obstacle(y,x) == 1 or get_ncpmap_obstacle(y,x) == 1 then
    return 1
  else
    return 0
  end
end

function on_interact(player, y, x)
  --check for mode
  if game.default_collision == "look" then
    on_get_obstacle_look(y,x) -- see what is blocking your path
  end
end

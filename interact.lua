--interact .lua, talk, look, etc
function on_interact(player, o)
end

function get_ncpmap_obstacle(y,x) --check if npc_map returned an obstacle
  if npc_map[y][x] == "@" then 
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

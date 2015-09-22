--interact .lua, talk, look, etc
function get_outofbounds(y,x)
  if y<1 or y > game.tilecount or x<1 or x >game.tilecount then
    return 1
  else
    return 0
  end
  
end
function on_get_obstacle_look(p) -- see what is blocking your path
  if player.facing == "north" then
    show_look_data(game_map[game.player_loc_y-1][game.player_loc_x], game.player_loc_x, game.player_loc_y-1)
  elseif player.facing == "east" then
    show_look_data(game_map[game.player_loc_y][game.player_loc_x+1], game.player_loc_x+1, game.player_loc_y)
  elseif player.facing == "south" then
    show_look_data(game_map[game.player_loc_y+1][game.player_loc_x], game.player_loc_x, game.player_loc_y+1)
  elseif player.facing == "west" then
    show_look_data(game_map[game.player_loc_y][game.player_loc_x-1], game.player_loc_x-1, game.player_loc_y)
  end
end
  
function get_ncpmap_obstacle(y,x) --check if npc_map returned an obstacle
  if npc_map[y][x] ~= 0 then 
    return 1
  else 
    return 0
  end
end

function get_obstacle(y,x) --test weather character is an obstacle
  if get_outofbounds(y,x) == 0 then
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
  elseif game.default_collision == "talk" then
    --set the draw/inupt mode for conversation.
  elseif game.default_collision == "steal" then
  elseif game.default_collision == "attack" then
  end
end

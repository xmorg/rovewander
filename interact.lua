--interact .lua, talk, look, etc
function on_interact(player, o)
end

function get_ncpmap_obstacle(c) --check if npc_map returned an obstacle
  if c == "@" then return 1
  else return 0
end

function get_obstacle(c) --test weather character is an obstacle
  if c == "#" then return 1
  elseif c == "t" then return 1
  elseif c == "l" then return 1
  else return 0
end

function get_any_obstacle(c)
  if get_obstacle(c) == 1 or get_ncpmap_obstacle(c) == 1 then
    return 1
  else
    return 0
  end
end

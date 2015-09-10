--interact .lua, talk, look, etc
function on_interact(player, o)
end

function get_obstacle(c) --test weather character is an obstacle
  if c == "#" then return 1
  elseif c == "t" then return 1
  elseif c == "l" then return 1
  else return 0
end

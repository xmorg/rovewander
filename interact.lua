--interact .lua, talk, look, etc
function get_outofbounds(y,x)
  if y<1 or y > game.tilecount or x<1 or x >game.tilecount then
    return 1
  else
    return 0
  end  
end


function map_outofbounds(x,y)
   if x < 1 or y < 1 or x > game.tilecount or y > game.tilecount then
      return true
   else
      return false
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

-- still gets null
function get_ncpmap_obstacle(y,x) --check if npc_map returned an obstacle
   if npc_map[y][x] == nil then return 0 end
   if npc_map[y][x] ~= nil and npc_map[y][x] ~= 0 and map_outofbounds(x,y) == false then 
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

function set_talk_target(x,y)
  --go through npc list and return the talk target?
  if npc_map[y][x] ~= 0 then --it must be an NPC!
    --get talk table by..item.
    game.mode = "talk"
  end
end

--function get_xy_target(x,y)--find x,y and return the npc target.
--end
function on_steal(x,y)
	if npc_map[y][x] ~= 0 then --encountered something
		game.current_message = "nothing to steal"
	else
		game.current_message = "nobody there"
	end
end

function hit_success(p, target)
   local player_attack_rand = math.random(1,6)
   local enemy_defense_rand = math.random(1,6)
   if player_attack_rand > enemy_defense_rand then --scored a hit.
      return 1
   else
      return 0
   end
end

function on_attack(x,y)
   local damage_dice = math.random(1,6) --roll dice to see how much damange you did. (or just 1d6 for now
   --things to consider, do we have a shield equiped?(rerolls defense)
   --How does the enemy react? Attacks, warns, runs away.
   if npc_map[y][x] ~= 0 then --do a dice roll, and subtract from enemies hp.
      if hit_sucess(player, npc_map[y][x]) == 1 then --scored a hit.
	 npc_map[y][x].health = npc_map[y][x].health - damage_dice
      else --did not hit
      end
   end
end
function on_interact(player, y, x)
    --check for mode
    if game.default_collision == "look" then
        on_get_obstacle_look(y,x) -- see what is blocking your path
    elseif game.default_collision == "talk" then
        game.mode = "talk" -- we are in talk mode now.
        set_talk_target(x,y) -- who is at x,y
        --set the draw/inupt mode for conversation.
    elseif game.default_collision == "steal" then on_steal()
    elseif game.default_collision == "attack" then
    end
end

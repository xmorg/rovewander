--interact .lua, talk, look, etc

require("factions")

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
   --if npc_map[y][x] == nil then return 0 end
   if y < 1 and y > table.getn(npc_map) and x < 1 and x > table.getn(npc_map) then return 0 end
   if y < 1 and y > table.getn(npc_map) and x < 1 and x > table.getn(npc_map) and map_outofbounds(x,y) == false then
   --if npc_map[y][x] ~= nil and npc_map[y][x] ~= 0 and map_outofbounds(x,y) == false then 
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


function on_look(x,y)
   if npc_map[y][x] ~= 0 then --encountered something
      
      game.current_message = npc_map[y][x].name.." the "..npc_map[y][x].a_type.. " "..sex_if_an(npc_map[y][x])
      game.current_messagel2 = npc_map[y][x].level..":"..npc_map[y][x].health..":"..get_faction_disp(player.a_type, npc_map[y][x].a_type) --factions[npc_map[y][x].a_type][1][1]
      game.mode = "message box"
   else
      game.current_message = "nothing to see here." --what are we looking at?
   end
end

function hit_sucess(p, target)
   local player_attack_rand = math.random(1,6)
   local enemy_defense_rand = math.random(1,6)
   if player_attack_rand > enemy_defense_rand then --scored a hit.
      return 1
   else
      return 0
   end
end

function get_range(x,y)
   local damage_dice = math.random(1,6)
   range_x = math.abs(player.loc_x - x)
   range_y = math.abs(player.loc_y - y)
   if range_x > player.max_range or range_y > player.max_range or range_x < player.min_range or range_y < player.min_range then
      inrange = false
   else
      inrange = true
   end
   return inrange
end

function on_attack(x,y)
   local damage_dice = math.random(1,6) --roll dice to see how much damange you did. (or just 1d6 for now
   --things to consider, do we have a shield equiped?(rerolls defense)
   --How does the enemy react? Attacks, warns, runs away. --check for range
   --range_x = math.abs(player.loc_x - x)
   --range_y = math.abs(player.loc_y - y)
   --if range_x > player.max_range or range_y > player.max_range or range_x < player.min_range or range_y < player.min_range then
   --   inrange = false
   --else
   --   inrange = true
   --end
   if npc_map[y][x] ~= 0 and get_range(x,y) == true then --do a dice roll, and subtract from enemies hp.
      if hit_sucess(player, npc_map[y][x]) == 1 then --scored a hit.
	 if npc_map[y][x].health <= 0 then
	    game.current_message = player.name .. " attacked " .. npc_map[y][x].name .. " but " .. npc_map[y][x].name.. " is alrealdy dead."
	 else
	    npc_map[y][x].health = npc_map[y][x].health - damage_dice
	    if npc_map[y][x].health <= 0 then
	       game.current_message = player.name .. " killed " .. npc_map[y][x].name .. " hitting for " .. damage_dice .. " points of damage."
	    else
	       game.current_message = player.name .. " attacked " .. npc_map[y][x].name .. " and hit for " .. damage_dice .. " points of damage."
	    end
	 end -- alive or dead
      else --did not hit
	 game.current_message = player.name .. " attacked " .. npc_map[y][x].name .. "and missed."
      end -- hit or miss
   else -- someone is not there.
      game.current_message = "nothing to attack here"
   end
end -- end function


function on_interact(player, y, x)
    --check for mode
    if game.default_collision == "look" then
        on_get_obstacle_look(y,x) -- see what is blocking your path
    elseif game.default_collision == "talk" then
        game.mode = "talk" -- we are in talk mode now.
        set_talk_target(x,y) -- who is at x,y
        --set the draw/inupt mode for conversation.
    elseif game.default_collision == "steal" then
       on_steal(x,y)
    elseif game.default_collision == "attack" then
       on_attack(x,y)
    end
end

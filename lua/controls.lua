--controls


function love.mousepressed(x, y, button)
   local px = game.player_loc_x
   local py = game.player_loc_y
   local dy = game.draw_y
   local dx = game.draw_x
   print(love.mouse.getPosition())
   

   
   function quickbuttonx(x,y,num)
      if x >= love.graphics.getWidth() -280
	 and x <= love.graphics.getWidth()-180
	 and y >=100+game.fsize*num+3
      and y <= 100+game.fsize*num+23 then
	 return 1
      else
	 return 0
      end
   end      
   
   if button == 1 then --left button?     
      if game.mode == "chargen" then
	 if player.edited == 1 then
	    --save player data
	    love.filesystem.write( "player.lua", table.show(player, "player")) 
	    game.mode = "message box" --97
	 end
      elseif game.mode == "message box" then --97
	 game.mode = "ingame"
      end

      if x >= love.graphics.getWidth() - 12*3 and x <= love.graphics.getWidth() and y>=0 and y <= 64 then
	 --exit
	 love.event.quit()
      elseif game.mode == "chargen" and x >= 23 and x <= 162 and y >= 293 and y <= 297   then
	 --23      293 -- randomize
	 --162     297
	 
	 --170     293
	 --258     297 -- start game
	 randomize_actor(player, nil)
      elseif game.mode == "chargen" and x >=170 and x <=258 and y >=293 and y <= 297 then
	 --start the game
	 a.max_health = update_init_maxhealth(a)
	 a.health = update_init_maxhealth(a)
	 game.mode = "message box"
	 player.edited = 1
	 --save player data
	 love.filesystem.write( "player.lua", table.show(player, "player")) 
	 game.mode = "message box" --97      
      elseif x >=  love.graphics.getWidth() - 12*6 and x <= love.graphics.getWidth() -12*3 and y>=0 and y <=64 then
	 --save and exit
	 if game.mode == "ingame" then
	    love.filesystem.write( "game.lua", table.show(game, "game")) --save game
	    love.filesystem.write( "player.lua", table.show(player, "player")) --save player
	    love.filesystem.write( "worldmap.lua", table.show(worldmap, "worldmap"))--save worldmap
	    --love.event.quit()
	 end --end
      elseif x >= love.graphics.getWidth() - 12*9 and x <= love.graphics.getWidth() -12*6 and y >=0 and y<=64 then
	 chunk = love.filesystem.load( "game.lua" )
	 chunk()--bug check for these files first!
	 chunk = love.filesystem.load( "player.lua" )
	 chunk()--bug check for these files first!
	 chunk = love.filesystem.load( "worldmap.lua" )
	 chunk()--bug check for these files first!
	 chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
	 --chunk = love.filesystem.load( worldmap[y-1][x][2]..".lua" )
	 chunk()
	 --end
	 -- movement
	 --elseif more mouse buttons
	 --draw_ingame_actions(love.graphics.getWidth() -280, 100)
	 --love.graphics.print("Actions", x, y)
	 --love.graphics.print("-------------------", x, y+game.fsize+3)
	 --love.graphics.print("(F1)Interact Mode", x, y+game.fsize*2+3)
	 --love.graphics.print("(c)haracter sheet", x, y+game.fsize*3+3)
	 --love.graphics.print("(i)nventory sheet", x, y+game.fsize*4+3)
	 --love.graphics.print("(q)aff a potion", x, y+game.fsize*5+3)
	 --love.graphics.print("l(o)ok around", x, y+game.fsize*6+3)
	 --love.graphics.print("(w)orld map", x, y+game.fsize*7+3)
	 --love.graphics.print("(t)alk", x, y+game.fsize*8+3)
	 --love.graphics.print("(a)ttack", x, y+game.fsize*9+3)
	 --love.graphics.print("(s)teal", x, y+game.fsize*10+3)
	 --love.graphics.print("(p)ick lock", x, y+game.fsize*11+3)
	 --quickbuttonx(x,y,num)
      --elseif x >= love.graphics.getWidth() -280	 and x <= love.graphics.getWidth()-180 and y >=100+game.fsize*2+3
      --and y <= 100+game.fsize+23 then
	 --toggle actions.
      elseif quickbuttonx(x,y,2) == 1 then
	 if game.default_collision == "attack" then game.default_collision = "look"
	 elseif game.default_collision == "look" then game.default_collision = "talk"
	 elseif game.default_collision == "talk" then game.default_collision = "steal"
	 elseif game.default_collision == "steal" then game.default_collision = "attack"
	 end
      elseif quickbuttonx(x,y,3) == 1 then --character sheet
	 if game.mode == "character sheet" then
	    game.mode = "ingame"
	 else
	    game.mode = "character sheet"
	 end
      elseif quickbuttonx(x,y,4) == 1 then
	 if game.mode == "inventory sheet" then
	    game.mode = "ingame"
	 else
	    game.mode = "inventory sheet"
	 end
      elseif quickbuttonx(x,y,5) == 1 then
	 game.current_message = "Can't Quaff yet!"
	 game.mode = "ingame"
      elseif quickbuttonx(x,y,6) == 1 then
	 game.mode = "look mode" -- look mode
	 game.default_collision = "look"
	 game.look_x = game.player_loc_x
	 game.look_y = game.player_loc_y
      elseif quickbuttonx(x,y,7) == 1 then
	 if game.mode == "world map" then
	    game.mode = "ingame"
	 elseif game.mode == "ingame" then
	    game.mode = "world map"
	 end
      elseif x >=0 and x <=100 and y >= love.graphics.getHeight()/10  and y <= love.graphics.getHeight()/10*9 then
	 --game.player_loc_x = game.player_loc_x -1
	 player.facing = "west"
	 if game_map[py][px-1] == "D" then
	    load_newzone("west", game.player_world_x, game.player_world_y)
	    game.player_world_x = game.player_world_x-1
	    game.player_loc_x = table.getn(game_map)-2
	    game.draw_x = game.draw_x- (table.getn(game_map)-2)*8
	    increase_gametime()
	 end
	 if px > 2 and get_any_obstacle(py, px-1)== 0 then
	    if npc_map[py][px-1] ~= 0 then
	    end
	    game.player_loc_x = game.player_loc_x -1
	    game.draw_x=game.draw_x+1*8
	    game.current_event = "player move"
	    increase_gametime()
	 else -- we encountered an obstacle!
	    if get_ncpmap_obstacle(py, px-1) == 1 then
	       on_interact(player, py, px-1)
	    end
	 end	   
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth() and y >= love.graphics.getHeight()/10
      and y <= love.graphics.getHeight()/10*9 then
	 --game.player_loc_x = game.player_loc_x +1
	 player.facing = "east"
	 if game_map[py][px+1] == "D" then
	    load_newzone("east", game.player_world_x, game.player_world_y)
	    game.player_world_x = game.player_world_x+1
	    game.player_loc_x = 2
	    game.draw_x = game.draw_x+ (table.getn(game_map)-2)*8
	    increase_gametime()
	 end
	 if  get_any_obstacle(py,px+1) == 0 then
	    game.player_loc_x = game.player_loc_x +1
	    game.draw_x=game.draw_x-1*8
	    game.current_event = "player move"
	    increase_gametime()
	 else -- we encountered an obstacle!
	    if get_ncpmap_obstacle(py, px+1) == 1 then
	       on_interact(player, py, px+1)
	    end
	 end
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 
      and y >= 0 and y <= 100 then
	 --game.player_loc_y = game.player_loc_y -1
	 player.facing = "north"
	 if game_map[py-1][px] == "D" then
	    load_newzone("north", game.player_world_x, game.player_world_y)
	    game.player_world_y = game.player_world_y-1
	    game.player_loc_y = table.getn(game_map)-2
	    game.draw_y = game.draw_y- (table.getn(game_map)-2)*14
	    increase_gametime()
	 end
	 if py > 2 and get_any_obstacle(py-1,px) == 0 then
	    game.player_loc_y = game.player_loc_y -1
	    game.draw_y=game.draw_y+1*14
	    game.current_event = "player move"
	    increase_gametime()
	 else -- we encountered an obstacle!
	    if get_ncpmap_obstacle(py-1, px) == 1 then
	       --interact
	       on_interact(player, py-1, px)
	    end
	 end
      elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9 and y <= love.graphics.getHeight() and y >= love.graphics.getHeight()/10*9 then
	 --game.player_loc_y = game.player_loc_y +1
	 player.facing = "south"
	 if game_map[py+1][px] == "D" then
	    load_newzone("south", game.player_world_x, game.player_world_y)
	    game.player_world_y = game.player_world_y+1
	    game.player_loc_y = 2
	    game.draw_y = game.draw_y + (table.getn(game_map)-2)*14
	    increase_gametime()
	 end
	 if get_any_obstacle(py+1,px) == 0 then --game.draw_y = game.draw_y -1
	    game.player_loc_y = game.player_loc_y +1
	    game.draw_y=game.draw_y-1*14
	    game.current_event = "player move"
	    increase_gametime()
	 else -- we encountered an obstacle!
	    if get_ncpmap_obstacle(py+1, px) == 1 then
	       --interact
	       on_interact(player, py+1, px)
	    end
	 end
      end--endif --elseif x >=love.graphics.getWidth()/10 and x <=love.graphics.getWidth()/10*9
   end--endif --mb=1
end

function activate_default_collision()
   if game.default_collision == "attack" then 
      on_attack(game.look_x, game.look_y)
   elseif game.default_collision == "look" then
      on_look(game.look_x, game.look_y)
   elseif game.default_collision == "talk" then
      a = 2
   elseif game.default_collision == "steal" then
      on_steal(game.look_x, game.look_y) --are we in range? when will we range check?
   end
end
function look_mode(key, isrepeat )
   local px = game.player_loc_x
   local py = game.player_loc_y
   local dy = game.draw_y
   local dx = game.draw_x
   if key == "escape" then
      game.mode = "ingame"
   elseif key == "o" then
      game.mode = "ingame"
   elseif key == "return" or key == "space" then
   	activate_default_collision()
   	game.mode = "ingame" -- activate the default_collision
      activate_default_collision()
   elseif (key == "right" or key == "l") then 
      game.look_x = game.look_x +1
   elseif (key == "left" or key == "h") then 
      game.look_x = game.look_x -1
   elseif (key == "up" or key == "k")  then
      game.look_y = game.look_y -1
   elseif (key == "down" or key == "j") then
      game.look_y = game.look_y +1
   end
end

function ingame_mode( key, isrepeat )
   local px = game.player_loc_x
   local py = game.player_loc_y
   local dy = game.draw_y
   local dx = game.draw_x
   if key == "escape" then
      love.event.quit()
   elseif key == "f1" then 
      if game.default_collision == "attack" then game.default_collision = "look"
      elseif game.default_collision == "look" then game.default_collision = "talk"
      elseif game.default_collision == "talk" then game.default_collision = "steal"
      elseif game.default_collision == "steal" then game.default_collision = "attack"
      end
   elseif key == "q" then
      --cant quaff yet!
      game.current_message = "Can't Quaff yet!"
      game.mode = "ingame"
   elseif key == "C" and game.mode == "ingame" then
      chunk = love.filesystem.load( "game.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( "player.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( "worldmap.lua" )
      chunk()--bug check for these files first!
      chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
      --chunk = love.filesystem.load( worldmap[y-1][x][2]..".lua" )
      chunk()
   elseif key == "o" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "look"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "t" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "talk"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "a" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "attack"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "s" then --changed o, lOOk
      game.mode = "look mode" -- look mode
      game.default_collision = "steal"
      game.look_x = game.player_loc_x
      game.look_y = game.player_loc_y
   elseif key == "S" then
      --save game(assume zone files are already saved
      love.filesystem.write( "game.lua", table.show(game, "game")) --save game
      love.filesystem.write( "player.lua", table.show(player, "player")) --save player
      love.filesystem.write( "worldmap.lua", table.show(worldmap, "worldmap"))--save worldmap
   elseif key == "w" then
	 game.mode = "world map"
   elseif key == "i" then 
      game.mode = "inventory sheet"
   elseif key == "c" then
      game.mode = "character sheet"
   elseif (key == "." or key == ">") and game.mode == "ingame" then
      if worldmap[game.player_world_y][game.player_world_x][1] == "d" then
	 if worldmap[game.player_world_y][game.player_world_x][3] == "" then
	    create_dungeon_map(100)
	    game_map[game.player_loc_y][game.player_loc_y] = "<"
	 else
	    chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][3].." Lv1"..".lua")
	    chunk()
	 end				
      end
   elseif (key == "," or key == "<") and game.mode == "ingame" then
      if worldmap[game.player_world_y][game.player_world_x][2] == "" then
	 --create_dungeon_map(100)
	 game_map[game.player_loc_y][game.player_loc_y] = "<"
      else
	 chunk = love.filesystem.load( worldmap[game.player_world_y][game.player_world_x][2]..".lua")
	 chunk()
      end
   elseif (key == "left" or key == "h") and game.mode == "ingame" then
      player.facing = "west"
      if game_map[py][px-1] == "D" then
	 load_newzone("west", game.player_world_x, game.player_world_y)
	 game.player_world_x = game.player_world_x-1
	 game.player_loc_x = table.getn(game_map)-2
	 game.draw_x = game.draw_x- (table.getn(game_map)-2)*8
	 increase_gametime()
      end
      if px > 2 and get_any_obstacle(py, px-1)== 0 then
	 if npc_map[py][px-1] ~= 0 then
	 end
	 game.player_loc_x = game.player_loc_x -1
	 game.draw_x=game.draw_x+1*8
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py, px-1) == 1 then
	    on_interact(player, py, px-1)
	 end
      end	   
   elseif (key == "right" or key == "l") and game.mode == "ingame" then
      player.facing = "east"
      if game_map[py][px+1] == "D" then
	 load_newzone("east", game.player_world_x, game.player_world_y)
	 game.player_world_x = game.player_world_x+1
	 game.player_loc_x = 2
	 game.draw_x = game.draw_x+ (table.getn(game_map)-2)*8
	 increase_gametime()
      end
      if  get_any_obstacle(py,px+1) == 0 then
	 game.player_loc_x = game.player_loc_x +1
	 game.draw_x=game.draw_x-1*8
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py, px+1) == 1 then
	    on_interact(player, py, px+1)
	 end
      end
   elseif (key == "up" or key == "k") then
      player.facing = "north"
      if game_map[py-1][px] == "D" then
	 load_newzone("north", game.player_world_x, game.player_world_y)
	 game.player_world_y = game.player_world_y-1
	 game.player_loc_y = table.getn(game_map)-2
	 game.draw_y = game.draw_y- (table.getn(game_map)-2)*14
	 increase_gametime()
      end
      if py > 2 and get_any_obstacle(py-1,px) == 0 then
	 game.player_loc_y = game.player_loc_y -1
	 game.draw_y=game.draw_y+1*14
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py-1, px) == 1 then
	    --interact
	    on_interact(player, py-1, px)
	 end
      end
   elseif (key == "down" or key == "j") and game.mode == "ingame" then
      player.facing = "south"
      if game_map[py+1][px] == "D" then
	 load_newzone("south", game.player_world_x, game.player_world_y)
	 game.player_world_y = game.player_world_y+1
	 game.player_loc_y = 2
	 game.draw_y = game.draw_y + (table.getn(game_map)-2)*14
	 increase_gametime()
      end
      if get_any_obstacle(py+1,px) == 0 then --game.draw_y = game.draw_y -1
	 game.player_loc_y = game.player_loc_y +1
	 game.draw_y=game.draw_y-1*14
	 game.current_event = "player move"
	 increase_gametime()
      else -- we encountered an obstacle!
	 if get_ncpmap_obstacle(py+1, px) == 1 then
	    --interact
	    on_interact(player, py+1, px)
	 end
      end
   end-- end if's	 
end -- end function ingame


function love.keypressed( key, isrepeat )
   if game.mode == "chargen" then
      update_actor_chargen(player, key, nil, nil, nil)
   elseif game.mode == "chargen_race_selector" then
      update_race_chargen(player, key, nil, nil, nil)
   elseif game.mode == "message box" then --""message box""
      if key == "retern" or key == "o" or key == "space" or key == "space" then
	 game.mode = "ingame"
      end
   elseif game.mode == "choice message box" then
      if key == "y" then
      	game.lastchoice = "yes"
      	game.mode = "ingame"
      elseif key == "n" then
      	game.lastchoice = "no"
      	game.mode = "ingame"
      end -- set a var in game.
   elseif game.mode == "talk" then
      update_talk_mode(player,key,nil, nil, nil)
   elseif game.mode == "look mode" then ------- LOOK MODE ------------------
      look_mode(key, isrepeat)
   elseif game.mode == "ingame" then  ------- IN GAME ----------------------
      ingame_mode( key, isrepeat )
   elseif game.mode == "world map" then --world map mode
      if key == "w" or key == "escape" then
	 game.mode = "ingame"
      end
   elseif game.mode == "character sheet" then
      if key == "c" then
	 game.mode = "ingame"
      end
   elseif game.mode == "inventory sheet" then
      if key == "i" then
	 game.mode = "ingame"
      elseif key == "escape" then
	 game.mode = "ingame"
      else
	 inventory_mode(key, isrepeat)
      end
   end--endif key
end--endfunction

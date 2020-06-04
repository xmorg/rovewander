game = { 
   mode = "chargen",
   tilecount = 30, 
   drawcount = 50,
   draw_x = 60, --where to start drawing the map
   draw_y = 10,
   player_loc_x = 15,
   player_loc_y = 15,
   look_x = player_loc_x,
   look_y = player_loc_y,
   player_world_x = 0,
   player_world_y = 0,
   default_collision = "attack",
   current_event = "none",
   last_choice = "no",
   current_message = "Sample Message",
   current_messagel2 = "none",
   time_day=0, time_hour=6, time_minute=0,
   fsize = 14 -- fontsize
}

game_map = {}
obj_map = {}
worldmap = {}
fogofwar = {}
npc_map = {}

require("actor")
require("factions")
require("primatives")
require("world")
require("message")
require("items")
require("interact")
require("controls")
require("render")

math.randomseed(os.time())

player = create_actor(game, 1, false)
player_inventory = {}

function increase_gametime() --time_day=0, time_hour=0, time_minute=0
   game.time_minute = game.time_minute+1
   if game.time_minute >= 60 then
      game.time_minute=0
      game.time_hour= game.time_hour+1
      if game.time_hour >=24 then
	 game.time_hour=0
	 game.time_day=game.time_day+1
      end
   end
end

function is_night() --checks to see if its day or night.
   if game.time_hour >= 21 and game.time_hour <= 4 then
      return true
   else 
      return false
   end
end




function npc_actions() --current event.
   local move_rand = math.random(0, 4) -- 0none,1north,2east,3south,4west
   for y=1,game.tilecount do
      for x=1,game.tilecount do
	 if npc_map[y][x] ~= 0 then
	    if npc_map[y][x].health > 0 then
	       npc_map[y][x].movestatus = "ready"
	    end
	 end
      end
   end
   if game.current_event == "player move" then
      for y=1, game.tilecount do
	 for x=1, game.tilecount do
	    if npc_map[y][x] ~= 0 then --move NPC
	       if move_rand == 1 and get_any_obstacle(y-1,x) == 0 and npc_map[y][x].movestatus == "ready" then --north
		  npc_map[y][x].movestatus = "finished" --move NPC
		  npc_map[y-1][x] = npc_map[y][x] --moved
		  npc_map[y][x] = 0 --filed vacume
	       elseif move_rand == 2 and get_any_obstacle(y,x+1) == 0 and npc_map[y][x].movestatus == "ready" then --east
		  npc_map[y][x].movestatus = "finished" --move NPC
		  npc_map[y][x+1] = npc_map[y][x] --moved
		  npc_map[y][x] = 0 --filed vacume
	       elseif move_rand == 3 and get_any_obstacle(y+1,x) == 0 and npc_map[y][x].movestatus == "ready" then --south
		  npc_map[y][x].movestatus = "finished"
		  npc_map[y+1][x] = npc_map[y][x] --moved
		  npc_map[y][x] = 0 --filed vacume
	       elseif move_rand == 4 and get_any_obstacle(y,x-1) == 0 and npc_map[y][x].movestatus == "ready" then --approved to move
		  npc_map[y][x].movestatus = "finished" --move NPC
		  npc_map[y][x-1] = npc_map[y][x] --moved
		  npc_map[y][x] = 0 --filed vacume
	       end
	    end
	 end
      end
   end --endif
end --end function

function update_process_events() --process events.
   if game.current_event == "player move" then
      --npc_map[actor_list[i].loc_y][actor_list[i].loc_x] = actor_list[i]
      --npc's should move sometimes
      npc_actions() --do it
      game.current_event = "none" -- ok we get it
   elseif game.current_event == "player steal" then
      --woa! pickpockets!
      game.current_event = "none" -- ok we get it
   elseif game.current_event == "player attack" then
      --combat happens!
      game.current_event = "none" -- ok we get it
   end
end

function love.update()
   local barrier_y = 0
   local barrior_x = 0
   local fnight = 0
   if is_night() == true then
      fnight = 0
   else
      fnight = 10
   end
   for y= -5-fnight, 5+fnight do
      for x= -5-fnight,5+fnight do
	 if game.player_loc_y+y > 0 and game.player_loc_x+x > 0 
	    and game.player_loc_y+y < game.tilecount+1 
	 and game.player_loc_x+x < game.tilecount+1 then
	    --if game_map[game.player_loc_y+y][game.player_loc_x+x]
	    --can currently see through walls :(
	    --what about daytime?
	    fogofwar[game.player_loc_y+y][game.player_loc_x+x] = 1
	 end
      end
   end
   update_process_events() --process events.
   player.loc_y = game.player_loc_y
   player.loc_x = game.player_loc_x
end

function setcolorbyChar(char)
   if char=="," then
      return 0,200,0,255
   elseif char=="t" then
      return 0,255,0,255
   elseif char=="l" then
      return 80,80,0,255
   elseif char=="~" then
      return 0,0,math.random(240,255),255
   elseif char=="." then
      return 100, 80, 15,255
   elseif char=="Y" then
      return 255, 255, 0, 255
   elseif char=="=" then
      return 100, 100, 15,255
   elseif char==">" or char=="<" then
      return 255, 255, 255, 255
   elseif char=="#" then
      return 70,70,70,255
   elseif char=="+" then
      return 60,60,60,255
   else
      return 255,0,0,255
   end
end


function love.draw()
   --love.graphics.scale(1.5)
   if game.mode == "ingame" then --game
      love.draw_cam_viewable()
   elseif game.mode == "chargen" then --chargen 100
      draw_chargen(player)
   elseif game.mode == "chargen_race_selector" then --update_race_chargen()
      draw_race_selector()
   elseif game.mode == "character sheet" then  --character status
      draw_char_info(player)
      draw_ingame_actions(love.graphics.getWidth() -280, 100)
   elseif game.mode == "world map" then --world map
      draw_worldmap()
      draw_ingame_actions(love.graphics.getWidth() -280, 100)
   elseif game.mode == "message box" then --message box 97
      love.draw_cam_viewable()
      draw_messagebox()
   elseif game.mode == "choice message box" then
      love.draw_cam_viewable()
      draw_choice_messagebox()
   elseif game.mode == "inventory sheet" then --inventory 96
      draw_inventory()
      draw_ingame_actions(love.graphics.getWidth() -280, 100)
   elseif game.mode == "look mode" then --look mode 95
      love.draw_cam_viewable()
   elseif game.mode == "talk" then
      love.draw_cam_viewable()	
      draw_border_conversation() -- coversation menu.
      --love.graphics.print("_", x*8-4+dx,y*14+dy )
   end
end

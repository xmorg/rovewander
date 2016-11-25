item_conditions = { "rusty", "tarnished", "polished", "keen", "fine"}
item_materials = { "wood", "bone", "flint", "copper", "brass", "bronze", "lead", "silver", "iron",
	"steel", "welded steel", "tempered steel" }
item_bow_materials = {"elm", "yew", "ash", "bone", "horn"}
quality_modifyers = {"studded", "encrusted", "plated"}

alphabet = {"a","b","f","g","h","j","k","l","m","n",
	    "o","p","q","r","s","t","u","v","w","x","y","z"} --c=character,i=inventory,d=drop,e=equip,E=Eat

item_weapons = {--name,slashing,piercing,bashing,grapling, equipped
	{"dagger", 1,2,0,2,1,eq=false},
	{"knife", 2,1,0,2,1,eq=false},
	{"club", 0,0,2,0,2,eq=false},
	{"short sword", 2,2,1,1,2,eq=false},
	{"long sword", 3,2,2,1,3 ,eq=false},
	{"great sword",4,2,3,2,4,eq=false},
	{"spear", 1,4,1,1,3,eq=false},
	{"mace", 0,0,3,0 ,3 ,eq=false},
	{"hammer", 0,0,3,1,3,eq=false},
	{"warhammer",0,1,4,1,4,eq=false}, 
	{"maul", 0,0,5,0,7,eq=false},
	{"trident",0,5,0,0,4,eq=false}, 
	{"lance",0,5,0,0,5,eq=false}, 
	{"pike", 1,5,1,0,5,eq=false},
	{"halbred", 3,2,2,2,6,eq=false}, 
	{"hand axe",3,0,2,2,2,eq=false},
	{"bearded axe",6,0,3,2,6,eq=false}, 
	{"heavy axe",8,0,3,2,7,eq=false}
}
item_armors = { --name, protection,resistance(to damage), integraty(piercing), weight, flame, cold, magic
	{"tunic", 0,1,0,5,0,2,0,eq=false}, 
	{"shirt", 0,1,0,5,0,2,0,eq=false},
	{"vest", 1,1,1,5,0,2,0,eq=false},
	{"hauberk",2,1,1,5,0,2,0,eq=false}, 
	{"mail", 3,2,2,5,0,2,0,eq=false},
	{"coat",4,3,3,5,0,2,0,eq=false},
	{"breastplate", 7,5,3,8,4,5,3,eq=false}
}
item_helmet = { --name, protection,resistance(to damage), integraty(piercing), weight, flame, cold, magic
	{"cap", 0,1,0,5,0,2,0,eq=false}, 
	{"hood", 0,1,0,5,0,2,0,eq=false},
	{"pot helm", 1,1,1,5,0,2,0,eq=false},
	{"nasal helm",2,1,1,5,0,2,0,eq=false}, 
	{"barbute", 3,2,2,5,0,2,0,eq=false},
	{"full helm",4,3,3,5,0,2,0,eq=false},
	{"great helm",4,3,3,5,0,2,0,eq=false},
	{"pigfaced helm",4,3,3,5,0,2,0,eq=false}
}
item_item = { --name, quanity_value, merc_value, food_value, quest_value
   {"marble", 1, 1, 0, 0 },
   {"ration", 1, 3, 1, 0 },
   {"melon",  1, 5, 5, 0 },
   {"bread loaf",1,5,2,0 },
   {"rum bottle",1,20,7,0},
   {"paper scrap",1,0,0,0},
   {"rope", 1, 20, 0, 0  }
}
function new_starting_weapon(newchar)
	--weapon name, condition, material, slashing, thrusting, bashing, weight, lore 
	item = {"", 0, 0,0,0,0,0,""}
	local condition = math.random(1,table.getn(item_conditions))
	local material = math.random(1,newchar)
	local name = math.random(1, table.getn(item_weapons))
	--7 possible materials for starting item
	item_name = item_conditions[condition].." "..item_materials[material].." "..item_weapons[name][1]
	item[1] = item_name
	item[2] = condition
	item[3] = material
	item[4] = item_weapons[name][2]
	item[5] = item_weapons[name][3]
	item[6] = item_weapons[name][4]
	item[7] = item_weapons[name][5]
	item[8] = item_weapons[name][6]
	item[9] = "weapon" --get type
	eq=false
	return item
end
function new_starting_armor(newchar)
	item = {"tunic", 0,1,0,5,0,2,0, "armor"}
	local condition = math.random(1,table.getn(item_conditions))
	local material = math.random(1,newchar)
	local name = math.random(1, table.getn(item_armors))
	item[1] = item_conditions[condition].." "..item_materials[material].." "..item_armors[name][1]
	item[2] = item_armors[2]
	item[3] = item_armors[3]
	item[4] = item_armors[4]
	item[5] = item_armors[5]
	item[6] = item_armors[6]
	item[7] = item_armors[7]
	item[8] = item_armors[8]
	item[9] = "armor"
	eq=false
	return item
end
function new_starting_helm(newchar)
	item = {"cap", 0,1,0,5,0,2,0, "helm"}
	local condition = math.random(1,table.getn(item_conditions))
	local material = math.random(1,newchar)
	local name = math.random(1, table.getn(item_helmet))
	item[1] = item_conditions[condition].." "..item_materials[material].." "..item_helmet[name][1]
	item[2] = item_helmet[2]
	item[3] = item_helmet[3]
	item[4] = item_helmet[4]
	item[5] = item_helmet[5]
	item[6] = item_helmet[6]
	item[7] = item_helmet[7]
	item[8] = item_helmet[8]
	item[9] = "helm"
	eq=false
	return item
end
function new_starting_item(newchar)
   
end
function inventory_is_selected(i)
   if i == player.selected_inventory then
      return "*"
   else
      return " "
   end      
end
function inventory_is_equipped(i)
   if player.selected_inventory>0 then
      if player.inventory[i].eq == true then
	 return "E"
      else
	 return " "
      end
   else
      return " "
   end
end
function draw_inventory()
   love.graphics.setColor(255,255,255,255)
   love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) --top
   love.graphics.setColor(0,0,0,255)
   love.graphics.rectangle("fill", 8,14, love.graphics.getWidth()-16, love.graphics.getHeight()-28)
   
   love.graphics.setColor(255,255,255,255)
   love.graphics.print(player.name.." Inventory", 16, 24)
   love.graphics.print("=========================", 16, 24+14)
   for i,v in ipairs(player.inventory) do
      love.graphics.print("("..alphabet[i]..")".."["..inventory_is_selected(i).."]["..inventory_is_equipped(i).."] "..player.inventory[i][1], 16, 52+ (14*i) )
   end

   if player.selected_inventory > 0 then
      love.graphics.print("(e)quip ", 300, 24+14)
      love.graphics.print("(C)onsume",300, 24+14*2 )
      love.graphics.print("(d)rop"  , 300, 24+14*3 )
   end
end

function player_drop_item(player, item)
   --remove from inventory, place on ground? do we need an items map?
   item_to_drop = 0
   for i,v in ipairs(player.inventory) do
      if i == item then
	 game.current_message = "dropped "..player.inventory[i][1]
	 item_to_drop=i
	 break
      end
   end
   table.remove(player.inventory, i)
end
function player_equip_item(player, item) -- how to check if its equipable?
   --there are weapon types, loop through items and if player.inventory[item][type]
   --is the same as another equipped item unequip other item
   item_to_eq = 0
   for i,v in ipairs(player.inventory) do
      if i == item then
	 game.current_message = "equipped "..player.inventory[i][1]
	 item_to_eq=i
	 break
      end
   end
   if item_to_eq > 0 then
      player.inventory[item_to_eq].eq = true
   else
      game.current_message = "you didnt equip anything{item_to_eq=0"
   end
end

function inventory_mode(key, isrepeat)
   for i,v in ipairs(player.inventory) do
      if key == alphabet[i] then
	 --you selected player.inventory[i]
	 player.selected_inventory = i
      elseif key == "e" and player.selected_inventory > 0 then
	 --try to equip player.inventory[i]
	 --how do i know its equipable!
	 --game.current_message = "that item cannot be equipped! (yet?)"
	 player_equip_item(player, player.selected_inventory) -- we are not checking for type at all???
	 --game.mode = "message box"
      elseif key == "C" and player.selected_inventory > 0 then
	 game.current_message = "that item cannot be eaten! (yet?)"
	 game.mode = "message box"
	 player.selected_inventory = 0
      elseif key == "d" and player.selected_inventory > 0 then
	 --game.current_message = "that item cannot be dropped! (yet?)"
	 player_drop_item(player,player.selected_inventory)
	 player.selected_inventory = 0
	 game.mode = "message box"
	 
      end
   end
end

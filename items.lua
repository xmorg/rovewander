item_materials = { "wood", "bone", "flint", "copper", "brass", "bronze", "lead", "silver", "iron",
	"steel", "welded steel", "tempered steel" }
item_bow_materials = {"elm", "yew", "ash", "bone", "horn"}
item_conditions = { "rusty", "tarnished", "polished", "keen", "fine"}
item_weapons = {"dagger", "knife", "club", "short sword", "long sword", "spear", "mace", "hammer", "warhammer", 
	"maul", "trident", "pike", "halbred", "hand axe", "bearded axe", "heavy axe"}
function new_starting_weapon()
	local condition = math.random(1,table.getn(item_conditions))
	local material = math.random(1,7)
	local weapon = math.random(1, table.getn(item_weapons))
	--7 possible materials for starting item
	item_name = item_conditions[condition].." "..item_materials[material].." "..item_weapons[weapon]
	return item_name
end
function draw_inventory()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) --top
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 8,14, love.graphics.getWidth()-16, love.graphics.getHeight()-28)

	love.graphics.setColor(255,255,255,255)
	love.graphics.print(player.name.." Inventory", 16, 24)
	love.graphics.print("=========================", 16, 24+14)
end

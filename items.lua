item_materials = { "wood", "bone", "flint", "copper", "brass", "bronze", "lead", "silver", "iron",
	"steel", "welded steel", "tempered steel" }
item_conditions = { "rusty", "tarnished"}
item_weapons = {"dagger", "knife", "short sword", "long sword", "spear", "mace", "hammer", "warhammer", 
	"maul", "trident", "pike", "halbred", "hand axe", "bearded axe", "heavy axe"}

function draw_inventory()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) --top
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 8,14, love.graphics.getWidth()-16, love.graphics.getHeight()-28)

	love.graphics.setColor(255,255,255,255)
	love.graphics.print(player.name.." Inventory", 16, 24)
	love.graphics.print("=========================", 16, 24+14)
end

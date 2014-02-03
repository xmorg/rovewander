
function create_actor(game, level,chargen) --create a random actor
	if chargen == false then
		a = {
				name = "random",
				a_type = "human",
				strength = 1,
				agility =  1,
				intel   =  1,
				stamina =  1,
				luck    =  1
		}
		if level > 1 then
			for x = 1, level do
				a.strength = math.random(0,3)
				a.agility =  math.random(0,3)
				a.intel   =  math.random(0,3)
				a.stamina =  math.random(0,3)
				a.luck    =  math.random(0,3)
			end
		end
	else -- chargen
		game.mode = 100
	end
	return a --return the actor to the "pointer" hehe.
end

function draw_chargen(actor) --stock actor has been generated
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), 14) --top
	love.graphics.rectangle("fill", 0,0, 8, love.graphics.getHeight() ) --left side
	love.graphics.rectangle("fill", 0,love.graphics.getHeight()-14, love.graphics.getWidth(), 14) --bottom
	love.graphics.rectangle("fill", love.graphics.getWidth()-8,0, 8, love.graphics.getHeight() )--right side
end

--message.lua file for processing messages/storyline

tl = 200

function draw_conversation_list(list)
	love.graphics.setColor(255,255,255,255)
	love.grpahics.print("(F)arewell", love.graphics.getWidth()/2+20, love.graphics.getHeight()-48))
end
function draw_border_conversation() -- coversation menu.
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", love.graphics.getWidth()/2,0, love.graphics.getWidth(), love.graphics.getHeight()) 
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", love.graphics.getWidth()/2+8,love.graphics.getWidth()+14, 
		love.graphics.getWidth()-16, love.graphics.getHeight()-28)
end

function draw_border_m(r, g, b, a)
	--tl = 20
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("fill", tl,tl, 400, 200) --top
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", tl+8,tl+14, 400-16, 200-28)
end

function draw_messagebox()
	draw_border_m(255,255,255,255)
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf(game.current_message, tl+20, tl+20, 300, "left")
	love.graphics.print("Click to continue", tl+20, tl+150)
end

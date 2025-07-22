local State = require("State")
local keypressed = require("keypressed")
local PlayingState = require("states.PlayingState")

---@class TitleScreenState: State
local TitleScreenState = State:new({
	name = "title",
})

function TitleScreenState:update()
	if keypressed.pressed("enter") or keypressed.pressed("return") then
		if self.state_machine then
			self.state_machine:change(PlayingState.name)
		end
	end
end
function TitleScreenState:render()
	love.graphics.setFont(Fonts.flappy)
	love.graphics.printf("Flappy Bird", 0, GAME_HEIGHT / 3, GAME_WIDTH, "center")

	love.graphics.setFont(Fonts.medium)
	love.graphics.printf("Press Enter", 0, GAME_HEIGHT / 3 + Fonts.flappy:getHeight() + 10, GAME_WIDTH, "center")
end

return TitleScreenState

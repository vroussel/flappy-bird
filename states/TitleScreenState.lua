local State = require("State")
local keypressed = require("keypressed")

---@class TitleScreenState: State
local TitleScreenState = State:new({
	name = "title",
})

function TitleScreenState:new()
	local s = State:new()
	setmetatable(s, self)
	self.__index = self

	return s
end

function TitleScreenState:update()
	if keypressed.pressed("enter") or keypressed.pressed("return") or keypressed.mouse_pressed(1) then
		if self.state_machine then
			self.state_machine:change(CountdownState.name)
		end
	end
end
function TitleScreenState:render()
	love.graphics.setFont(Fonts.flappy)
	love.graphics.printf("Flappy Bird", 0, GAME_HEIGHT / 3, GAME_WIDTH, "center")

	local action
	if RunningFromWeb() then
		action = "Click"
	else
		action = "Press Enter"
	end
	love.graphics.setFont(Fonts.medium)
	love.graphics.printf(action, 0, GAME_HEIGHT / 3 + Fonts.flappy:getHeight() + 10, GAME_WIDTH, "center")
end

return TitleScreenState

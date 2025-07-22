local State = require("State")
local keypressed = require("keypressed")

---@class ScoreState: State
---@field score number
local ScoreState = State:new({
	name = "score",
})

function ScoreState:new()
	local s = State:new()
	setmetatable(s, self)
	self.__index = self

	s.score = nil

	return s
end

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update()
	if keypressed.pressed("enter") or keypressed.pressed("return") then
		if self.state_machine then
			self.state_machine:change(PlayingState.name)
		end
	end
end
function ScoreState:render()
	love.graphics.setFont(Fonts.huge)
	love.graphics.printf(
		"Score: " .. self.score,
		0,
		GAME_HEIGHT / 2 - love.graphics.getFont():getHeight() / 2,
		GAME_WIDTH,
		"center"
	)

	love.graphics.setFont(Fonts.medium)
	love.graphics.printf(
		"Press Enter to play again",
		0,
		GAME_HEIGHT / 3 + Fonts.huge:getHeight() + 10,
		GAME_WIDTH,
		"center"
	)
end

return ScoreState

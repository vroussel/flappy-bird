local State = require("State")
local keypressed = require("keypressed")
local Timer = require("Timer")

---@class ScoreState: State
---@field score number
---@field show_play_again_timer Timer
local ScoreState = State:new({
	name = "score",
})

function ScoreState:new()
	local s = State:new()
	setmetatable(s, self)
	self.__index = self

	s.score = nil
	s.show_play_again_timer = Timer:new(1)

	return s
end

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update(dt)
	self.show_play_again_timer:update(dt)
	if self.show_play_again_timer:finished() then
		if keypressed.pressed("enter") or keypressed.pressed("return") or keypressed.mouse_pressed(1) then
			if self.state_machine then
				self.state_machine:change(CountdownState.name)
			end
		end
	end
end
function ScoreState:render()
	love.graphics.setFont(Fonts.flappy)
	love.graphics.printf(
		"Score: " .. self.score,
		0,
		GAME_HEIGHT / 2 - love.graphics.getFont():getHeight() / 2,
		GAME_WIDTH,
		"center"
	)

	if self.show_play_again_timer:finished() then
		local action
		if RunningFromWeb() then
			action = "Click"
		else
			action = "Press Enter"
		end
		love.graphics.setFont(Fonts.medium)
		love.graphics.printf(
			action .. " to play again",
			0,
			GAME_HEIGHT / 3 + Fonts.huge:getHeight() + 10,
			GAME_WIDTH,
			"center"
		)
	end
end

return ScoreState

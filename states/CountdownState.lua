local State = require("State")
local Timer = require("Timer")

---@class CountdownState: State
---@field private timer Timer
local CountdownState = State:new({
	name = "countdown",
})

function CountdownState:new()
	local s = State:new()
	setmetatable(s, self)
	self.__index = self

	s.timer = Timer:new(3)
	s.timer:set_time_speed(1.5)

	return s
end

function CountdownState:enter()
	self.timer:reset()
end

function CountdownState:update(dt)
	self.timer:update(dt)
	if self.timer:remaining() == 0 then
		self.state_machine:change(PlayingState.name)
	end
end

function CountdownState:render()
	love.graphics.setFont(Fonts.flappy)
	love.graphics.printf(
		math.ceil(self.timer:remaining()),
		0,
		GAME_HEIGHT / 2 - love.graphics.getFont():getHeight() / 2,
		GAME_WIDTH,
		"center"
	)
end

return CountdownState

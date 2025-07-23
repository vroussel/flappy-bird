---@class Timer
---@field duration number
---@field elapsed number
---@field time_speed number
local Timer = {}

function Timer:new(duration)
	local t = {}
	setmetatable(t, self)
	self.__index = self

	t.duration = duration
	t.elapsed = 0
	t.time_speed = 1

	return t
end

function Timer:update(dt)
	self.elapsed = self.elapsed + dt * self.time_speed
end

function Timer:reset()
	self.elapsed = 0
end

function Timer:finished()
	return self.elapsed >= self.duration
end

function Timer:remaining()
	return math.max(0, self.duration - self.elapsed)
end

function Timer:set_time_speed(speed)
	self.time_speed = speed
end

return Timer

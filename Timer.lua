---@class Timer
---@field duration number
---@field elapsed number
local Timer = {}

function Timer:new(duration)
	local t = {}
	setmetatable(t, self)
	self.__index = self

	t.duration = duration
	t.elapsed = 0

	return t
end

function Timer:update(dt)
	self.elapsed = self.elapsed + dt
end

function Timer:reset()
	self.elapsed = 0
end

function Timer:finished()
	return self.elapsed >= self.duration
end

return Timer

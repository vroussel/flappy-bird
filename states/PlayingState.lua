local Bird = require("Bird")
local Timer = require("Timer")
local PipePair = require("PipePair")

local PIPES_SPAWN_DELAY = 2.5

---@class PlayingState: State
---@field bird Bird
---@field pipe_pairs PipePair[]
---@field pipe_spawn_timer Timer
local PlayingState = {
	name = "playing",
}

function PlayingState:new()
	local s = {}
	setmetatable(s, self)
	self.__index = self

	s.bird = Bird:new()
	s.pipe_pairs = {}
	s.pipe_spawn_timer = Timer:new(PIPES_SPAWN_DELAY)

	return s
end

function PlayingState:enter() end

function PlayingState:exit() end

function PlayingState:update(dt)
	self.bird:update(dt)

	self:_cleanup_pipes()
	self:_spawn_pipes(dt)

	for _, p in ipairs(self.pipe_pairs) do
		p:update(dt)
		if p:collides_with(self.bird) then
			love.event.quit()
		end
	end
end

function PlayingState:render()
	self.bird:render()

	for _, p in ipairs(self.pipe_pairs) do
		p:render()
	end
end

function PlayingState:keypressed(key, _)
	if key == "space" then
		self.bird:jump()
	end
end

---@private
function PlayingState:_spawn_pipes(dt)
	self.pipe_spawn_timer:update(dt)
	if self.pipe_spawn_timer:finished() then
		table.insert(self.pipe_pairs, PipePair:new())
		self.pipe_spawn_timer:reset()
	end
end

---@private
function PlayingState:_cleanup_pipes()
	for i, p in ipairs(self.pipe_pairs) do
		if p.x + p.width < 0 then
			table:remove(i)
		else
			-- Pipes are ordered so we can break as soon as we encounter an "on-screen" one
			break
		end
	end
end

return PlayingState

local Bird = require("Bird")
local Timer = require("Timer")
local PipePair = require("PipePair")
local State = require("State")
local keypressed = require("keypressed")

local PIPES_SPAWN_DELAY = 2.5

---@class PlayingState: State
---@field bird Bird
---@field pipe_pairs PipePair[]
---@field pipe_spawn_timer Timer
---@field private score number
local PlayingState = State:new({
	name = "playing",
})

function PlayingState:new()
	local s = State:new()
	setmetatable(s, self)
	self.__index = self

	s.bird = Bird:new()
	s.pipe_pairs = {}
	s.pipe_spawn_timer = Timer:new(PIPES_SPAWN_DELAY)
	s.score = 0

	return s
end

function PlayingState:enter() end

function PlayingState:exit() end

function PlayingState:update(dt)
	if keypressed.pressed("space") then
		self.bird:jump()
	end
	self.bird:update(dt)

	self:_cleanup_pipes()
	self:_spawn_pipes(dt)

	for _, p in ipairs(self.pipe_pairs) do
		p:update(dt)
		if p:collides_with(self.bird) then
			if self.state_machine then
				self.state_machine:change(ScoreState.name, { score = self.score })
			end
		elseif not p.scored and self.bird.x > p.x + p.width then
			p.scored = true
			self.score = self.score + 1
		end
	end
end

function PlayingState:render()
	self.bird:render()

	for _, p in ipairs(self.pipe_pairs) do
		p:render()
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

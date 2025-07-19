local utils = require("utils")
---@class Pipe
---@field x number
---@field y number
---@field width number
---@field height number
---@field side 'up'|'down'
local Pipe = {}

local SPRITE = love.graphics.newImage("assets/pipe.png")
local PIPE_WIDTH = SPRITE:getWidth()
local PIPE_HEIGHT = SPRITE:getHeight()

function Pipe:new(x, y, side)
	local p = {}
	setmetatable(p, Pipe)
	self.__index = self

	p.x = x
	p.y = y
	p.width = PIPE_WIDTH
	p.height = PIPE_HEIGHT

	p.side = side

	return p
end

function Pipe:update(dt)
	self.x = self.x - GAME_SCROLL_SPEED * dt
end

function Pipe:render()
	if self.side == "up" then
		love.graphics.draw(SPRITE, self.x, self.y)
	else
		love.graphics.draw(SPRITE, self.x, self.y + PIPE_HEIGHT, 0, 1, -1)
	end
end

---@class PipePair
---@field gap number
---@field x number
---@field y number
---@field top_pipe Pipe
---@field bottom_pipe Pipe
local PipePair = {}

function PipePair:new()
	local p = {}
	setmetatable(p, self)
	self.__index = self

	p.x = GAME_WIDTH
	p.y = math.random(GAME_HEIGHT * 0.2, GAME_HEIGHT * 0.8)
	p.gap = math.random(60, 90)

	p.top_pipe = Pipe:new(p.x, p.y - p.gap / 2 - PIPE_HEIGHT, "down")
	p.bottom_pipe = Pipe:new(p.x, p.y + p.gap / 2, "up")

	p.width = PIPE_WIDTH

	return p
end

function PipePair:update(dt)
	self.top_pipe:update(dt)
	self.bottom_pipe:update(dt)
end

function PipePair:render()
	self.top_pipe:render()
	self.bottom_pipe:render()
end

function PipePair:collides_with(obj)
	local tolerance = { x = 10, y = 0 }
	return utils.check_collision(obj, self.top_pipe, tolerance)
		or utils.check_collision(obj, self.bottom_pipe, tolerance)
end

return PipePair

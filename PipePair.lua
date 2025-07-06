local utils = require("utils")
---@class Pipe
---@field x number
---@field y number
---@field width number
---@field height number
---@field side 'up'|'down'
local Pipe = {}

local SCROLL_SPEED = 60

local SPRITE = love.graphics.newImage("assets/pipe.png")

function Pipe:new(x, y, side)
	local p = {}
	setmetatable(p, Pipe)
	self.__index = self

	p.width = SPRITE:getWidth()
	p.height = SPRITE:getHeight()
	p.x = x
	if side == "up" then
		p.y = y
	else
		p.y = y - p.height
	end

	p.side = side

	return p
end

function Pipe:update(dt)
	self.x = self.x - SCROLL_SPEED * dt
end

function Pipe:render()
	if self.side == "up" then
		love.graphics.draw(SPRITE, self.x, self.y)
	else
		love.graphics.draw(SPRITE, self.x, self.y, 0, 1, -1, 0, self.height)
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
	p.gap = math.random(50, 100)

	p.top_pipe = Pipe:new(p.x, p.y - p.gap / 2, "down")
	p.bottom_pipe = Pipe:new(p.x, p.y + p.gap / 2, "up")

	p.width = p.top_pipe.width

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
	return utils.check_collision(obj, self.top_pipe) or utils.check_collision(obj, self.bottom_pipe)
end

return PipePair

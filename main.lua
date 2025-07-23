local love = require("love")
local push = require("push")
local keypressed = require("keypressed")
local StateMachine = require("StateMachine")

PlayingState = require("states.PlayingState")
TitleScreenState = require("states.TitleScreenState")
ScoreState = require("states.ScoreState")
CountdownState = require("states.CountdownState")

GAME_WIDTH = 432
GAME_HEIGHT = 243
GAME_SCROLL_SPEED = 60

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local background_scroll = 0
local ground_scroll = 0
local scrolling_enabled = true

---@type love.Image
local background_img
---@type love.Image
local ground_img

---@type StateMachine
local state_machine

Fonts = {}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	background_img = love.graphics.newImage("assets/background.png")
	ground_img = love.graphics.newImage("assets/ground.png")

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = true, fullscreen = false })
	push.setupScreen(GAME_WIDTH, GAME_HEIGHT, { upscale = "normal" })

	math.randomseed(os.time())

	state_machine = StateMachine:new({
		[PlayingState.name] = function()
			return PlayingState:new()
		end,
		[TitleScreenState.name] = function()
			return TitleScreenState:new()
		end,
		[ScoreState.name] = function()
			return ScoreState:new()
		end,
		[CountdownState.name] = function()
			return CountdownState:new()
		end,
	}, TitleScreenState.name)

	Fonts = {
		small = love.graphics.newFont("font.ttf", 8),
		medium = love.graphics.newFont("flappy.ttf", 14),
		flappy = love.graphics.newFont("flappy.ttf", 28),
		huge = love.graphics.newFont("flappy.ttf", 56),
	}

	love.window.setTitle("Flappy Bird")
end

function love.resize(w, h)
	push.resize(w, h)
end

function love.keypressed(key, _)
	if key == "q" then
		love.event.quit()
	end
	keypressed.push(key)
end

function love.update(dt)
	if scrolling_enabled then
		background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
		ground_scroll = (ground_scroll + GAME_SCROLL_SPEED * dt) % GAME_WIDTH
	end
	state_machine:update(dt)
	keypressed.reset()
end

function love.draw()
	push.start()

	love.graphics.draw(background_img, 0 - background_scroll, 0)
	love.graphics.draw(ground_img, 0 - ground_scroll, GAME_HEIGHT - ground_img:getHeight())
	state_machine:render()

	push.finish()
end

function SetScrolling(v)
	scrolling_enabled = v
end

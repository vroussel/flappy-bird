local love = require("love")
local push = require("push")
local Bird = require("Bird")
local keypressed = require("keypressed")

GAME_WIDTH = 432
GAME_HEIGHT = 243

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

local background_scroll = 0
local ground_scroll = 0

---@type love.Image
local background_img
---@type love.Image
local ground_img

---@type Bird
local bird

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	background_img = love.graphics.newImage("assets/background.png")
	ground_img = love.graphics.newImage("assets/ground.png")

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = true, vsync = true, fullscreen = false })
	push.setupScreen(GAME_WIDTH, GAME_HEIGHT, { upscale = "normal" })

	math.randomseed(os.time())

	bird = Bird:new()

	love.window.setTitle("Flappy Bird")
end

function love.resize(w, h)
	push.resize(w, h)
end

function love.keypressed(key, code)
	keypressed.notify(key, code)
	if key == "q" then
		love.event.quit()
	end
end

function love.update(dt)
	background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % GAME_WIDTH

	bird:update(dt)
end

function love.draw()
	push.start()

	love.graphics.draw(background_img, 0 - background_scroll, 0)
	love.graphics.draw(ground_img, 0 - ground_scroll, GAME_HEIGHT - ground_img:getHeight())

	bird:render()

	push.finish()
end

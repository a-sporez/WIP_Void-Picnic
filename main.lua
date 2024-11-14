local love = require('love')
local GameState = require('scripts.states.gamestate')
local Menu = require('scripts.states.menu')
local Running = require('scripts.states.running')

function love.load()
    GameState:switch(Menu)
end

function love.update(dt)
    GameState:update(dt)
end

function love.draw()
    GameState:draw()
end

function love.mousepressed(x, y, button)
    if GameState.currentState and GameState.currentState.mousepressed then
        GameState.currentState:mousepressed(x, y, button)
    end
end

function love.keypressed(key)
    if key == '1' then
        GameState:switch(Menu)
    elseif key == '2' then
        GameState:switch(Running)
    end
end
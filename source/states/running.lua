local interface     = require('source.utility.canvas.Interface')
local WorldHandler  = require('source.scenes.world.worldHandler')
local Void          = require('source.scenes.world.worldVoid')
local Nebula        = require('source.scenes.world.worldNebula')
local monitor       = require('source.utility.canvas.Monitor')

local Running = {}
-- holding instances in variables
local worldHandler
local Monitor

local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()

function Running:enter()
    print("[DEBUG] Entering Running state")

    worldHandler = WorldHandler:new()

    local voidWorld = Void:new()
    voidWorld:init()
    worldHandler:addWorld('void', voidWorld)

    local nebulaWorld = Nebula:new()
    nebulaWorld:init()
    worldHandler:addWorld('nebula', nebulaWorld)

-- Set initial world
    worldHandler:switch('void')
    print("[DEBUG] Current world set to:", worldHandler.currentWorld)

-- Initialize Monitor, which also initializes the playerShip
    Monitor = monitor:create(window_width, window_height, worldHandler.currentWorld)

    Interface = interface:create(window_width, window_height)
end

function Running:update(dt)
    print("[DEBUG] Updating Running state")

-- Update active world
    worldHandler:update(dt)

-- Update Monitor (handles playerShip and rendering logic)
    Monitor:update(dt)

-- Keep the Monitor in sync with the current world
    if Monitor.currentWorld ~= worldHandler.currentWorld then
        print("[DEBUG] Updating Monitor's current world")
        Monitor:setWorld(worldHandler.currentWorld)
    end
end

function Running:draw()
    print("[DEBUG] Drawing Running state")
    Monitor:render()
    Interface:render()
    Interface:draw()
    love.graphics.print("running", 10, 10)
end


function Running:textinput(key)
    Interface:textinput(key)
end

function Running:mousepressed(x, y, button)
    Interface:mousepressed(x, y, button)
    Monitor:mousepressed(x, y, button)
end

function Running:keypressed(key)
    if key == '1' then
        worldHandler:switch('void')
    elseif key == '2' then
        worldHandler:switch('nebula')
    end
    Interface:keypressed(key)
    Monitor:keypressed(key)
end

function Running:keyreleased(key)
    Interface:keyreleased(key)
    Monitor:keyreleased(key)
end

return Running
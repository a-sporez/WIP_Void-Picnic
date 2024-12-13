local interface     = require('source.utility.canvas.Interface')
local WorldHandler  = require('source.scenes.world.worldHandler')
local Void          = require('source.scenes.world.worldVoid')
local Nebula        = require('source.scenes.world.worldNebula')
local monitor       = require('source.utility.canvas.Monitor')
local Camera        = require('source.utility.Camera')
local Surveyor      = require('source.classes.vessels.surveyor')

local Running = {}
-- holding instances in variables
local worldHandler
local Monitor
local playerShip

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

    Monitor = monitor:create(window_width, window_height, worldHandler.currentWorld)

    Camera:init(window_width / 2, window_height / 2)
    Camera:setZoom(1)

    self.Interface = interface:create(window_width, window_height)

    -- Initialize the Surveyor playerShip here
    playerShip = Surveyor:create(window_width / 2, window_height / 2)
    -- add playerShip to currentWorld
    table.insert(worldHandler.currentWorld.entities, playerShip)
end

function Running:update(dt)
    print("[DEBUG] Updating Running state")
-- update active world
    worldHandler:update(dt)

    if playerShip then
        playerShip:update(dt)
    end
-- update the camera to focus on the first entity in the world
    local currentWorld = worldHandler.currentWorld
    if currentWorld and #currentWorld.entities > 0 then
        local focusEntity = currentWorld.entities[1]
        Camera.update(focusEntity.x, focusEntity.y)
    end

    if Monitor.currentWorld ~= currentWorld then
        print("[DEBUG] Updating Monitor's current world")
        Monitor:setWorld(currentWorld)
    end
end

function Running:draw()
    print("[DEBUG] Drawing Running state")
    love.graphics.print("running", 10, 10)

    Camera:attach()
    Monitor:render()
    if playerShip then
        playerShip:draw()
    end
    Camera:detach()
    Monitor:draw()

    self.Interface:render()
    self.Interface:draw()
end

function Running:textinput(key)
    self.Interface:textinput(key)
end

function Running:keypressed(key)
    local panning = 10
    if key == '1' then
        worldHandler:switch('void')
    elseif key == '2' then
        worldHandler:switch('nebula')
    elseif key == 'up' then
        Camera:move(0, -panning)
    elseif key == 'down' then
        Camera:move(0, panning)
    elseif key == 'left' then
        Camera:move(-panning, 0)
    elseif key == 'right' then
        Camera:move(panning, 0)
    elseif key == 'pageup' then
        Camera:adjustZoom(0.1)
    elseif key == 'pagedown' then
        Camera:adjustZoom(-0.1)
    end
    self.Interface:keypressed(key)
end

function Running:mousepressed(x, y, button)
    self.Interface:mousepressed(x, y, button)
    playerShip:mousepressed(x, y, button)
end

return Running
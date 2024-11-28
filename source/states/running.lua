local interface     = require('source.utility.interface.Interface')
local WorldHandler  = require('source.scenes.world.worldHandler')
local Void          = require('source.scenes.world.worldVoid')
local Nebula        = require('source.scenes.world.worldNebula')
local CanvasMonitor = require('source.utility.canvasMonitor')
local Camera        = require('source.utility.Camera')

local Running = {}
local worldHandler
local canvasMonitor

local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()

function Running:enter()
    print("Entering Running state")

    worldHandler = WorldHandler:new()

    local voidWorld = Void:new()
    voidWorld:init()
    worldHandler:addWorld('void', voidWorld)

    local nebulaWorld = Nebula:new()
    nebulaWorld:init()
    worldHandler:addWorld('nebula', nebulaWorld)

    -- Set initial world
    worldHandler:switch('void')
    print("Current world set to:", worldHandler.currentWorld)

    canvasMonitor = CanvasMonitor:create(window_width, window_height, worldHandler.currentWorld)

    Camera:init(window_width / 2, window_height / 2)
    Camera:setZoom(1)

    self.Interface = interface.new()
end

function Running:update(dt)
    print("Updating Running state")
-- update active world
    worldHandler:update(dt)
-- update the camera to focus on the first entity in the world
    local currentWorld = worldHandler.currentWorld
    if currentWorld and #currentWorld.entities > 0 then
        local focusEntity = currentWorld.entities[1]
        Camera.update(focusEntity.x, focusEntity.y)
    end

    if canvasMonitor.currentWorld ~= currentWorld then
        print("Updating CanvasMonitor's current world")
        canvasMonitor:setWorld(currentWorld)
    end
end

function Running:draw()
    print("Drawing Running state")
    love.graphics.print("running", 10, 10)

    Camera:attach()
    canvasMonitor:render()
    Camera:detach()
    canvasMonitor:draw()

    self.Interface:draw()
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
    end
end

function Running:mousepressed(x, y, button)
    self.Interface:mousepressed(x, y, button)
end

return Running
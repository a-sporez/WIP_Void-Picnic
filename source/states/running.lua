--luacheck: ignore dt

local GameState     = require('source.states.gamestate')
local Buttons       = require('source.classes.buttons.Button')
local WorldHandler  = require('source.scenes.world.worldHandler')
local Void          = require('source.scenes.world.Void')
local Nebula        = require('source.scenes.world.Nebula')
local CanvasMonitor = require('source.scenes.world.canvasMonitor')
local Camera        = require('source.scenes.world.Camera')

local Running = {}
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local offset_x, offset_y = 48, 18
local worldHandler
local canvasMonitor

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

    canvasMonitor = CanvasMonitor:new(window_width, window_height, worldHandler.currentWorld)

    Camera.init(window_width / 2, window_height / 2)
    Camera.setZoom(1)

    self.menuButton = Buttons.new(
        window_width - offset_x * 2,
        window_height - offset_y * 2,
        96,
        36,
        "MENU",
        function() GameState:enableMenu() end,
        nil,
        'assets/sprites/button_1.png'
    )
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

    Camera.attach()
    canvasMonitor:render()
    Camera.detach()
    canvasMonitor:draw()

    self.menuButton:draw(self.button_x, self.button_y, 14, 7)
end

function Running:keypressed(key)
    if key == '1' then
        worldHandler:switch('void')
    elseif key == '2' then
        worldHandler:switch('nebula')
    end
end

function Running:mousepressed(x, y, button)
    if button == 1 and self.menuButton then
        self.menuButton:checkPressed(x, y, button)
        print("click")
    end
end

return Running
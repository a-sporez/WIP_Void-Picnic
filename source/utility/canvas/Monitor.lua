local Canvas = require('source.utility.canvas.Canvas')
local Surveyor = require('source.classes.vessels.surveyor')
local Camera   = require('source.utility.Camera')

-- This submodule declares the canvas where elements of the world are drawn.
local Monitor = setmetatable({}, { __index = Canvas })

local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()

-- Pass dimensions and currentWorld from the base class
function Monitor:create(width, height, currentWorld)
    local canvas = Canvas:new(width, height, currentWorld)
    setmetatable(canvas, { __index = self })

    Camera:init(window_width / 2, window_height / 2)
    Camera:setZoom(1)

-- Initialize playerShip
    canvas:initializePlayerShip(width / 2, height / 2)
    return canvas
end

-- Dynamically update the world that the canvas is rendering.
function Monitor:setWorld(world)
    self.currentWorld = world
-- If the playerShip isn't already in this world, add it
    if self.playerShip and not table.contains(world.entities, self.playerShip) then
        table.insert(world.entities, self.playerShip)
    end
end

-- Initialize the player ship and add it to the current world.
function Monitor:initializePlayerShip(x, y)
    if not self.currentWorld then
        print("[ERROR] Cannot initialize playerShip without a current world.")
        return
    end

-- Create the Surveyor (or other ship class)
    self.playerShip = Surveyor:create(x, y)

-- Add it to the current world's entities
    table.insert(self.currentWorld.entities, self.playerShip)
end

-- Update method for the Monitor, including playerShip.
function Monitor:update(dt)
    if self.playerShip then
        self.playerShip:update(dt)
        Camera:update(self.playerShip.x, self.playerShip.y)
    end
end

-- Render the world and the player ship.
function Monitor:render()
    Camera:attach()
    if not self.currentWorld then
        print("[ERROR] No current world to render")
        return
    end

    print("[DEBUG] Rendering canvas for world")
    self:start()
    self.currentWorld:draw()

    -- Render the player ship if it exists
    if self.playerShip then
        self.playerShip:draw()
    end

    self:stop()
    Camera:detach()
end

-- Pass mouse events to the playerShip
function Monitor:mousepressed(x, y, button)
    if self.playerShip then
        self.playerShip:mousepressed(x, y, button)
    end
end

function Monitor:keypressed(key)
    if self.playerShip then
        self.playerShip:keypressed(key)
    end
    local panning = 10
    if key == 'up' then
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
end

function Monitor:keyreleased(key)
    if self.playerShip then
        self.playerShip:keyreleased(key)
    end
end

return Monitor
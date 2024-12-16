local Canvas = require('source.utility.canvas.Canvas')
local Surveyor = require('source.classes.vessels.surveyor')

-- This submodule declares the canvas where elements of the world are drawn.
local Monitor = setmetatable({}, { __index = Canvas })

-- Pass dimensions and currentWorld from the base class
function Monitor:create(width, height, currentWorld)
    local canvas = Canvas:new(width, height, currentWorld)
    setmetatable(canvas, { __index = self })

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
    end
end

-- Render the world and the player ship.
function Monitor:render()
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
end

function Monitor:keyreleased(key)
    if self.playerShip then
        self.playerShip:keyreleased(key)
    end
end

return Monitor
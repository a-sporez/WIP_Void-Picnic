--[[
This is the default world to test things.
--]]
local World         = require('source.scenes.world.World')
local Asteroid      = require('source.entities.asteroids.Asteroid')

local Void = World:new(4000, 4000)

function Void:init()
    print("[DEBUG] Initializing Void")
    self.asteroid = self:addEntity(Asteroid:new(500, 1400))
end

function Void:update(dt)
    print("[DEBUG] Updating Void World")
    World.update(self, dt)
end

function Void:draw()
    print("[DEBUG] Drawing Void World")
    love.graphics.print("World: Void", 10, 30)
    World.draw(self)
end

return Void
--[[
This is the default world to test things and create debug boilerplate early dev.
TODO: integrate camera
--]]
local World         = require('source.scenes.world.World')
local SurveyDrone   = require('source.entities.drones.surveyDrone')
local Asteroid      = require('source.entities.asteroids.Asteroid')

local Void = World:new(4000, 4000)

function Void:init()
    print("[DEBUG] Initializing Void")
    self.survey2 = self:addEntity(SurveyDrone:new(600, 600))
    self.asteroid = self:addEntity(Asteroid:new(500, 1400))
end

function Void:update(dt)
    print("[DEBUG] Updating Void World")
    self.survey2:update(dt)
    World.update(self, dt)
end

function Void:draw()
    print("[DEBUG] Drawing Void World")
    love.graphics.print("World: Void", 10, 30)
    World.draw(self)
end

return Void
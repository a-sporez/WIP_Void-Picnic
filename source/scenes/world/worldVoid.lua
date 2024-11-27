--[[
This is the default world to test things and create debug boilerplate early dev.
TODO: integrate camera
--]]
local World         = require('source.scenes.world.World')
local SurveyDrone   = require('source.classes.drones.surveyDrone')

local Void = World:new(4000, 4000)

function Void:init()
    print("Initializing Void")
    self.survey2 = self:addEntity(SurveyDrone:new(600, 600))
end

function Void:update(dt)
    print("Updating Void World")
    self.survey2:move(-10, -10, dt)
    World.update(self, dt)
end

function Void:draw()
    print("Drawing Void World")
    love.graphics.print("World: Void", 10, 30)
    World.draw(self)
end

return Void
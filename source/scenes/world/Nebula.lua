-- secondary test world
local World         = require('source.scenes.world.World')
local SurveyDrone   = require('source.classes.drones.surveyDrone')

local Nebula = World:new(4000, 4000)

function Nebula:init()
    print("Initializing Nebula")
    self.survey2 = self:addEntity(SurveyDrone:new(600, 600))
end

function Nebula:update(dt)
    print("Updating Nebula World")
    self.survey2:move(10, 10, dt)
    World.update(self, dt)
end

function Nebula:draw()
    print("Drawing Nebula World")
    love.graphics.print("World: Nebula", 10, 30)
    World.draw(self)
end

return Nebula
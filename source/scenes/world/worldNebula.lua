-- secondary test world
local World         = require('source.scenes.world.World')
local SurveyDrone   = require('source.entities.drones.surveyDrone')

local Nebula = World:new(4000, 4000)

function Nebula:init()
    print("[DEBUG] Initializing Nebula")
    self.survey2 = self:addEntity(SurveyDrone:new(600, 600))
end

function Nebula:update(dt)
    print("[DEBUG] Updating Nebula World")
    self.survey2:update(dt)
    World.update(self, dt)
end

function Nebula:draw()
    print("[DEBUG] Drawing Nebula World")
    love.graphics.print("World: Nebula", 10, 30)
    World.draw(self)
end

return Nebula
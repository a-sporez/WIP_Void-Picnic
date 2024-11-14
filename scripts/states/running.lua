--luacheck: ignore dt
local love = require('love')
local SurveyDrone = require('scripts.classes.drones.survey')

local Running = {}

function Running:enter()
    self.survey2 = SurveyDrone:new(600, 600)
end

function Running:update(dt)
    self.survey2:move(-1, -1)
end

function Running:draw()
    love.graphics.print("running", 10, 10)
    self.survey2:draw()
end

return Running
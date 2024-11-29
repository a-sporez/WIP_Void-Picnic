local vector = require('libraries.vector')
local Mothership = {}

function Mothership:new(x, y, width, height, hardpoints)
    local obj = {
        position = vector(x, y),
        velocity = vector(0, 0),
        friction = 0.99,
        width = width or 256,
        height = height or 192,
        angle = 0,
        state = 'passive',
        hardpoints = hardpoints or {}
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- update the motherships position and declare state as conditions
function Mothership:update(dt, input)
    if  self.state == 'passive' then
        self:keypressed(input)
        self:updatePassive(dt)
        print("mothership passive update")
    elseif self.state == 'command' then
        self:updateCommand(dt)
        print("mothership command update")
    end
    self:updatePosition(dt)
end

function Mothership:updatePassive(dt)
    
end

function Mothership:updateCommand(dt)
    
end

function Mothership:updatePosition(dt)
    self.position = self.position + self.velocity * dt
    self.velocity = self.velocity * self.friction
end

function Mothership:addHardpoint(hardpoint)
    table.insert(self.hardpoints, hardpoint)
end

function Mothership:switchCommand(newState)
    self.state = newState
end

function Mothership:draw()
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(self.angle)
    love.graphics.rectangle('line', -self.width / 2, -self.height / 2, self.width, self.height)
    for _, hp in ipairs(self.hardpoints) do
        hp:draw(self.position, self.angle)
    end
    love.graphics.pop()
end

return Mothership
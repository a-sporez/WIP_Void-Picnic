local vector = require('libraries.vector')
local Mothership = {}

function Mothership:new(x, y, width, height, hardpoints, sprite_path)
    local sprt = love.graphics.newImage(sprite_path)
    local obj = {
        position = vector(x, y),
        velocity = vector(10, 10),
        friction = 0.99,
        width = width or 256,
        height = height or 128,
        angle = 0,
        state = 'passive',
        hardpoints = hardpoints,
        sprite = sprt
    }
    self.__index = self
    return setmetatable(obj, self)
end

-- update the motherships position and declare state as conditions
function Mothership:update(dt, input)
    if  self.state == 'passive' then
        self:keypressed(input)
        self:updatePassive(dt)
        print("[DEBUG] mothership passive update")
    elseif self.state == 'command' then
        self:updateCommand(dt)
        print("[DEBUG] mothership command update")
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
    love.graphics.draw(self.sprite, -self.width / 2, -self.height / 2)
    print("[DEBUG] drawing ship at position:", self.position)
    for i, hp in ipairs(self.hardpoints) do
        print("[DEBUG] drawing hardpoint#"..i)
-- Pass the local origin, the hardpoints are already being transformed.
        hp:draw({x = 0, y = 0}, 0)
    end
    love.graphics.pop()
-- this debug print is to verify the user data for the playership
    print(string.format("[DEBUG] Drawing ship at: (%.2f, %.2f) | Angle: %.2f", self.position.x, self.position.y, self.angle))
end

function Mothership:keypressed(input)
-- Placeholder for keypress logic
    print("[DEBUG] Key pressed: ", input)
end

return Mothership
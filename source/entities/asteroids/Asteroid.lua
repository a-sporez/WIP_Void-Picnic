local vector = require('libraries.hump.vector')
local Asteroid = {}

function Asteroid:new(x, y, width, height)
--    local sprt = spritePath and love.graphic.newImage(spritePath) or nil
    local sprt = love.graphics.newImage('assets/sprites/asteroids/ast1.png')
    assert(sprt, "[ERROR-DRONE] Invalid spritePath provided!")
    print("[DEBUG-DRONE] Sprite dimensions>", sprt:getWidth(), sprt:getHeight())
    local obj = {
        position = vector(x, y),
        velocity = vector(0, 0),
        max_velocity = 10,
        friction = 0.995,
        width = width or sprt:getWidth(),
        height = height or sprt:getHeight(),
        sprite = sprt,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Asteroid:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.position.x, self.position.y)
end

return Asteroid
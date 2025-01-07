local vector = require('libraries.hump.vector')
local colors = require('source.utility.colors')
local Drone = {}

--[[
TODO: Extend to load sprite
TODO: Extend to carry hardpoints
--]]

-- constructor function for the Drone class base methods
function Drone:new(x, y, drone_type)
    print("[DEBUG-DRONE] Drone type received:", drone_type)
    print("[DEBUG-DRONE] Self is:", self)

    local sprite_paths = {
        ['survey'] = 'assets/sprites/drones/survey.png'
    }

    local sprite_path = sprite_paths[drone_type]
    if not sprite_path then
        error("[ERROR-DRONE] Invalid drone type: " .. tostring(drone_type))
    end

    local sprite = love.graphics.newImage(sprite_path)

    local obj = {
        position = vector(x, y),
        velocity = vector(0, 0),
        target = nil,
        max_velocity = 10,
        friction = 0.995,
        sprite = sprite,
        width = sprite:getWidth(),
        height = sprite:getHeight(),
        drone_type = drone_type,
        selected = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Drone:update(dt)
    if self.target then
        local direction = self.target - self.position
        local distance = direction:len()

        if distance > 5 then
            direction:normalizeInplace()
            self.velocity = direction * self.max_velocity
        else
            self.velocity = vector(0, 0)
            self.target = nil
        end
    end
    self.velocity = self.velocity * self.friction
    self.position = self.position + self.velocity * dt
end

function Drone:isClicked(mouse_x, mouse_y)
    return mouse_x > (self.position.x - self.width / 2) and
           mouse_x < (self.position.x + self.width / 2) and
           mouse_y > (self.position.y - self.height / 2) and
           mouse_y < (self.position.y + self.height / 2)
end

function Drone:mousepressed(mouse_x, mouse_y, button)
    print("[DEBUG-DRONE] Mouse pressed at:", mouse_x, mouse_y)
    print("[DEBUG-DRONE] Drone position:", self.position)

    if not self.position then
        error("[ERROR-DRONE] Drone position is nil")
    end

    if button == 1 then
        if self:isClicked(mouse_x, mouse_y) then
            self.selected = not self.selected
        end
    elseif button == 2 then
        if self.selected then
            self:setTarget(mouse_x, mouse_y)
        end
    end
end

function Drone:setTarget(target_x, target_y)
    self.target = vector(target_x, target_y)
end

function Drone:draw()
    if self.sprite then
        love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.width / 2, self.height / 2)
    else
        love.graphics.ellipse('fill', self.position.x, self.position.y, self.width, self.height)
    end
    if self.selected then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle('line', self.position.x - self.width / 2 - 2, self.position.y - self.height / 2 - 2, self.width + 4, self.height + 4)
        love.graphics.setColor(1, 1, 1) -- Reset color to white
    end
    if self.target then
        love.graphics.setColor(colors.red)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

return Drone
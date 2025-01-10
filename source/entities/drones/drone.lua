local Entity = require('source.entities.entity') -- Adjust the path as needed
local vector = require('libraries.hump.vector')
local colors = require('source.utility.colors')

local Drone = {}
setmetatable(Drone, {__index = Entity}) -- Inherit from Entity

function Drone:new(x, y, drone_type)
    -- Define sprite paths for drone types
    local sprite_paths = {
        ['survey'] = 'assets/sprites/drones/survey.png'
    }
    local spritePath = sprite_paths[drone_type]
    assert(spritePath, "[ERROR-DRONE] Invalid drone type: " .. tostring(drone_type))

    -- Call Entity constructor
    local drone = Entity.new(self, x, y, nil, nil, spritePath)
    drone.drone_type = drone_type
    drone.max_velocity = 10
    drone.friction = 0.995
    setmetatable(drone, self)
    return drone
end

function Drone:update(dt)
    -- Call base update to handle position and velocity
    Entity.update(self, dt)

    -- Drone-specific targeting logic
    if self.target then
        local direction = self.target - self.position
        local distance = direction:len()

        if distance > 5 then
            direction:normalizeInplace()
            self.velocity = direction * self.max_velocity
        else
            -- Stop when close to the target
            self.velocity = vector(0, 0)
            self.target = nil
        end
    end
end

function Drone:isClicked(mouse_x, mouse_y)
    -- Use Entity's position and dimensions to determine if clicked
    return mouse_x > (self.position.x - self.width / 2) and
           mouse_x < (self.position.x + self.width / 2) and
           mouse_y > (self.position.y - self.height / 2) and
           mouse_y < (self.position.y + self.height / 2)
end

function Drone:mousepressed(mouse_x, mouse_y, button)
    -- Call base mousepressed for selection logic
    Entity.mousepressed(self, mouse_x, mouse_y, button)

    if button == 2 and self.selected then
        self:setTarget(mouse_x, mouse_y)
    end
end

function Drone:setTarget(target_x, target_y)
    -- Override Entity's setTarget for debug logging
    self.target = vector(target_x, target_y)
    print(string.format("[DEBUG-DRONE] Target set to (%.2f, %.2f)", target_x, target_y))
end

function Drone:draw()
    -- Call base draw to render the sprite
    Entity.draw(self)

    -- Add drone-specific visuals (e.g., selection and targeting)
    if self.selected then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle('line', self.position.x - self.width / 2 - 2, self.position.y - self.height / 2 - 2, self.width + 4, self.height + 4)
        love.graphics.setColor(1, 1, 1) -- Reset color
    end
    if self.target then
        love.graphics.setColor(colors.red)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

return Drone
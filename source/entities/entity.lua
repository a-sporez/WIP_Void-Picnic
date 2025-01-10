local vector = require('libraries.hump.vector')

local Entity = {}

function Entity:new(x, y, width, height, sprite_path)
    local sprite = sprite_path and love.graphics.newImage(sprite_path) or nil
    assert(sprite, "[ERROR-ENTITIES] Invalid spritePath provided!")
    local obj = {
        position = vector(x, y),
        velocity = vector(0, 0),
        width = width or (sprite and sprite:getWidth()),
        height = height or (sprite and sprite:getHeight()),
        selected = false,
        angle = 0,
        friction = 0.995,
        target = nil,
        sprite = sprite,
    }
    self.__index = self
    return setmetatable(obj, self)
end

function Entity:toggleSelected()
    self.selected = not self.selected
    if self.target then
        self.target = nil
    end
end

function Entity:setTarget(x, y)
    self.target = vector(x, y)
end

function Entity:clearTarget()
    self.target = nil
end

function Entity:update(dt)
    -- Apply velocity and friction
    self.velocity = self.velocity * self.friction
    self.position = self.position + self.velocity * dt
end

function Entity:updatePosition(dt)
    -- Can be overridden by derived classes for specific position updates
end

function Entity:draw()
    if self.sprite then
        love.graphics.draw(
            self.sprite,
            self.position.x,
            self.position.y,
            self.angle,
            1,
            1,
            self.width / 2,
            self.height / 2
        )
    end
    if self.target then
        -- Draw a line to the target
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1) -- Reset color
    end
end

function Entity:mousepressed(mouse_x, mouse_y, button)
    -- Translate mouse position relative to the entity's position
    local localMouseX = mouse_x - self.position.x
    local localMouseY = mouse_y - self.position.y
    -- Rotate mouse position into the entity's local space
    local rotatedX = localMouseX * math.cos(-self.angle) - localMouseY * math.sin(-self.angle)
    local rotatedY = localMouseX * math.sin(-self.angle) + localMouseY * math.cos(-self.angle)
    -- Check if the point is within the sprite's bounds
    local halfWidth = self.width / 2
    local halfHeight = self.height / 2

    if button == 1 then
        -- Left mouse button: toggle selection or clear target
        if rotatedX >= -halfWidth and rotatedX <= halfWidth and
           rotatedY >= -halfHeight and rotatedY <= halfHeight then
            self:toggleSelected()
        elseif self.selected then
            -- If already selected and clicked outside, unselect
            self:toggleSelected()
        else
            self:clearTarget()
        end
    elseif button == 2 and self.selected then
        -- Right mouse button: set a new target if selected
        self:setTarget(mouse_x, mouse_y)
    end
end

return Entity
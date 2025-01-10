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

function Entity:update(dt)
    self.velocity = self.velocity * self.friction
    self.position = self.position + self.velocity * dt
end

function Entity:updatePosition(dt)
    
end

function Entity:draw()
    
end

function Entity:mousepressed(mouse_x, mouse_y, button)
-- Translate mouse position relative to the vessel's position
    local localMouseX = mouse_x - self.position.x
    local localMouseY = mouse_y - self.position.y
-- Rotate mouse position into the vessel's local space
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
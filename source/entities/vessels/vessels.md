# Vessels

[hardpoints](hardpoints/hardpoints.md)

[modules](modules/modules.md)

- ## Constructor

```lua
function Vessel:new(x, y, width, height, hardpoints, spritePath)
    local sprt = spritePath and love.graphics.newImage(spritePath) or nil
    assert(sprt, "[ERROR-VESSEL] Invalid spritePath provided!")

    local obj = {
        target = nil,
        selected = false,
        position = vector(x, y),
        velocity = vector(0, 0),
        max_velocity = 10,
        friction = 0.995,
        width = width or sprt:getWidth(),
        height = height or sprt:getHeight(),
        angle = 0,
        rotation = 0,
        rotation_speed = math.rad(90),
        hardpoints = hardpoints,
        sprite = sprt,
        input = Input:new()
    }
    self.__index = self
    return setmetatable(obj, self)
end
```

- ### Mouse input handling

```lua
function Vessel:mousepressed(mouse_x, mouse_y, button)
    local localMouseX = mouse_x - self.position.x
    local localMouseY = mouse_y - self.position.y
    local rotatedX = localMouseX * math.cos(-self.angle) - localMouseY * math.sin(-self.angle)
    local rotatedY = localMouseX * math.sin(-self.angle) + localMouseY * math.cos(-self.angle)
    local halfWidth = self.width / 2
    local halfHeight = self.height / 2

    if button == 1 then
        if rotatedX >= -halfWidth and rotatedX <= halfWidth and
           rotatedY >= -halfHeight and rotatedY <= halfHeight then
            self:toggleSelected()
        else
            self.selected = false
        end
    elseif button == 2 and self.selected then
        self:setTarget(mouse_x, mouse_y)
    end
end
```
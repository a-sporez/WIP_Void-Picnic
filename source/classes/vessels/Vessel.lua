local vector = require('libraries.vector')
local colors = require('source.lib.colors')
local Vessel = {}

function Vessel:new(x, y, width, height, hardpoints, spritePath)
    local sprt = love.graphics.newImage(spritePath)
    local obj = {
        target = nil,
        selected = false,
        position = vector(x, y),
        velocity = vector(10, 10),
        friction = 0.995,
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

function Vessel:toggleSelected()
    self.selected = not self.selected
end

function Vessel:setTarget(x, y)
    self.target = vector(x, y)
    print(string.format("[DEBUG] Setting target to (%.2f, %.2f)", x, y))
end

function Vessel:mousepressed(mouse_x, mouse_y, button)
    
-- Translate mouse position relative to the vessel's position
    local localMouseX = mouse_x - self.position.x
    local localMouseY = mouse_y - self.position.y

-- Rotate mouse position into the vessel's local space
    local rotatedX = localMouseX * math.cos(-self.angle) - localMouseY * math.sin(-self.angle)
    local rotatedY = localMouseX * math.sin(-self.angle) + localMouseY * math.cos(-self.angle)

-- Check if the point is within the sprite's bounds
    local halfWidth = self.width / 2
    local halfHeight = self.height / 2

-- left mouse click to select and deselect
    if button == 1 then
        if rotatedX >= -halfWidth and rotatedX <= halfWidth and
        rotatedY >= -halfHeight and rotatedY <= halfHeight then
            self:toggleSelected()
        elseif button == 1 and self.selected then
            self.selected = false
        end
-- right mouse click to set the target destination
    elseif button == 2 and self.selected then
        self:setTarget(mouse_x, mouse_y)
    end
end

function Vessel:storeModule(module)
    if self.hangar.occupied < self.hangar.capacity then
        table.insert(self.hangar.modules, module)
        self.hangar.occupied = self.hangar.occupied + 1
        print(string.format("[DEBUG] Module %s stored. Used: %d/%d", module.name, self.hangar.occupied, self.hangar.capacity))
        return true
    else
        print("[ERROR] Hangar full.")
        return false
    end
end

function Vessel:listModules()
    print("[DEBUG] Mods in hangar:")
    for i, module in ipairs(self.hangar.modules) do
        print(string.format(" [%d] %s", i, module.name))
    end
end

function Vessel:removeModule(moduleName)
    for i, module in ipairs(self.hangar.modules) do
        if module.name == moduleName then
            table.remove(self.modules, i)
            self.hangar.capacity = self.hangar.capacity - 1
            print(string.format("[DEBUG] Module %s removed."))
            return module
        end
    end
    print(string.format("[ERROR] Module %s not found.", moduleName))
    return nil
end

-- update the Vessels position and declare state as conditions
function Vessel:update(dt, input)
    if  self.state == 'passive' then
        self:keypressed(input)
        self:updatePassive(dt)
        print("[DEBUG] Vessel passive update")
    elseif self.state == 'command' then
        self:updateCommand(dt)
        print("[DEBUG] Vessel command update")
    end
    self:updatePosition(dt)
end

function Vessel:updatePassive(dt)
    -- TODO: create automated logic for base class
end

function Vessel:updateCommand(dt)
    -- TODO: create manual control logic for base class
end

function Vessel:updatePosition(dt)
    self.position = self.position + self.velocity * dt
    self.velocity = self.velocity * self.friction
end

function Vessel:addHardpoint(hardpoint)
    table.insert(self.hardpoints, hardpoint)
end

function Vessel:switchCommand(newState)
    self.state = newState
end

function Vessel:draw()
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(self.angle)

    if self.selected then
        love.graphics.setColor(colors.green)
        love.graphics.rectangle('line', -self.width / 2, -self.height / 2, self.width, self.height)
    end

    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(self.sprite, -self.width / 2, -self.height / 2)

    print("[DEBUG] drawing ship at position:", self.position)

    for i, hp in ipairs(self.hardpoints) do
        print("[DEBUG] drawing hardpoint#"..i)
-- Pass the local origin, the hardpoints are already being transformed.
        hp:draw({x = 0, y = 0}, 0)
    end

    love.graphics.pop()

    if self.target then
        love.graphics.setColor(colors.red)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1)
    end

-- this debug print is to verify the user data for the playership
    print(string.format("[DEBUG] Drawing ship at: (%.2f, %.2f) | Angle: %.2f", self.position.x, self.position.y, self.angle))
end

function Vessel:keypressed(input)
-- Placeholder for keypress logic
    print("[DEBUG] Key pressed: ", input)
end

return Vessel
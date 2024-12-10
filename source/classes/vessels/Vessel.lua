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

function Vessel:mousepressed(mouse_x, mouse_y, cursor_radius)
    if (mouse_x + cursor_radius >= self.position.x and
        mouse_x - cursor_radius <= self.position.x + self.width) and
        (mouse_y + cursor_radius >= self.position.y and
        mouse_y - cursor_radius <= self.position.y + self.height) then
        if self.selected then
            self.selected = false
        else
            self.selected = true
        end
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
    else
        love.graphics.setColor(colors.light_grey)
    end
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

function Vessel:keypressed(input)
-- Placeholder for keypress logic
    print("[DEBUG] Key pressed: ", input)
end

return Vessel
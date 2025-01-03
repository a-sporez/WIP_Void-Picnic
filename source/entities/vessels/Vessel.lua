local vector = require('libraries.hump.vector')
local colors = require('source.utility.colors')
local Input  = require('source.utility.InputHandler')
local Vessel = {}

function Vessel:new(x, y, width, height, hardpoints, spritePath)
    local sprt = spritePath and love.graphics.newImage(spritePath) or nil
    assert(sprt, "[ERROR-VESSEL] Invalid spritePath provided!")

    local obj = {
        target = nil,
        selected = false,
        position = vector(x, y),
        velocity = vector(0, 0),
        thrust = 1,
        friction = 0.995,
        width = width or sprt:getWidth(),
        height = height or sprt:getHeight(),
        angle = 0,
        rotation = 0,
        rotation_speed = math.rad(15),
        hardpoints = hardpoints,
        sprite = sprt,
        input = Input:new()
    }
    self.__index = self
    return setmetatable(obj, self)
end

function Vessel:toggleSelected()
    self.selected = not self.selected
    if self.target then
        self.target = nil
    end
end

function Vessel:setTarget(x, y)
    self.target = vector(x, y)
    print(string.format("[DEBUG-VESSEL] Setting target to (%.2f, %.2f)", x, y))
end

--[[
TODO:
    + store targets
    + clear targets, max_reached, idle_10
    + get current target and return output.
--]]

function Vessel:storeNav(target)
    
end

function Vessel:clearTarget()
    if self.target then
        self.target = nil
    end
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

    if button == 1 then
        if rotatedX >= -halfWidth and rotatedX <= halfWidth and
           rotatedY >= -halfHeight and rotatedY <= halfHeight then
            self:toggleSelected()
        else
            self:clearTarget()
        end
    elseif button == 1 and self.selected then
        self:toggleSelected()
    elseif button == 2 and self.selected then
        self:setTarget(mouse_x, mouse_y)
    end
end

function Vessel:applyThrust(thrust)
    -- calculate forward direction based on ship angle
    local direction = vector(math.cos(self.angle), math.sin(self.angle))
    -- scale direction with thrust magnitude
    local thrust_vector = direction * thrust
    self.velocity = self.velocity + thrust_vector
end

function Vessel:turnClockwise()
    self.rotation = self.rotation_speed
end

function Vessel:turnCounterClockwise()
    self.rotation = -self.rotation_speed
end

function Vessel:handleInput()
-- Check for movement input using the Input system
    if self.input:continuous('forward') then
        self:applyThrust(self.thrust)
    elseif self.input:continuous('backward') then
        self:applyThrust(-self.thrust)
    end

    if self.input:continuous('left_rot') then
        self:turnCounterClockwise()
    elseif self.input:continuous('right_rot') then
        self:turnClockwise()
    end
end

function Vessel:storeModule(module)
    if self.hangar.occupied < self.hangar.capacity then
        table.insert(self.hangar.modules, module)
        self.hangar.occupied = self.hangar.occupied + 1
        print(string.format("[DEBUG-VESSEL] Module %s stored. Used: %d/%d", module.name, self.hangar.occupied, self.hangar.capacity))
        return true
    else
        print("[ERROR-VESSEL] Hangar full.")
        return false
    end
end

function Vessel:listModules()
    print("[DEBUG-VESSEL] Mods in hangar:")
    for i, module in ipairs(self.hangar.modules) do
        print(string.format(" [%d] %s", i, module.name))
    end
end

function Vessel:removeModule(moduleName)
    for i, module in ipairs(self.hangar.modules) do
        if module.name == moduleName then
            table.remove(self.modules, i)
            self.hangar.capacity = self.hangar.capacity - 1
            print(string.format("[DEBUG-VESSEL] Module %s removed."))
            return module
        end
    end
    print(string.format("[DEBUG-VESSEL] Module %s removed.", moduleName))
    return nil
end

-- update the Vessels position and declare state as conditions
function Vessel:update(dt)
    self.input:clear()
    self:handleInput()
    self:updatePosition(dt)
end

function Vessel:updatePosition(dt)
    self.position = self.position + self.velocity * dt
    self.velocity = self.velocity * self.friction
    self.rotation = self.rotation * self.friction
    self.angle = self.angle + self.rotation * dt
end

function Vessel:addHardpoint(hardpoint)
    table.insert(self.hardpoints, hardpoint)
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

    print("[DEBUG-VESSEL] drawing ship at position:", self.position)

    for i, hp in ipairs(self.hardpoints) do
        print("[DEBUG-VESSEL] drawing hardpoint#"..i)
-- Pass the local origin, the hardpoints are already being transformed.
        hp:draw({x = 0, y = 0}, 0)
    end

    love.graphics.pop()

    if self.target then
        love.graphics.setColor(colors.red)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1) -- Reset color
    end

-- this debug print is to verify the user positions for the ship and hardpoints.
    print(string.format("[DEBUG-VESSEL] Drawing ship at: (%.2f, %.2f) | Angle: %.2f", self.position.x, self.position.y, self.angle))
end

function Vessel:keypressed(key)
    self.input:keypressed(key)
end

function Vessel:keyreleased(key)
    self.input:keyreleased(key)
end

return Vessel
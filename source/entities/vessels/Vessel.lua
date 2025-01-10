local Entity    = require('source.entities.entity') -- Adjust path as necessary
local vector    = require('libraries.hump.vector')
local colors    = require('source.utility.colors')
local Input     = require('source.utility.InputHandler')

local Vessel = {}
setmetatable(Vessel, {__index = Entity}) -- Inherit from Entity

function Vessel:new(x, y, width, height, hardpoints, spritePath)
    local vessel = Entity.new(self, x, y, width, height, spritePath) -- Call base constructor
    vessel.hardpoints = hardpoints or {}
    vessel.thrust = 1
    vessel.rotation = 0
    vessel.rotation_speed = math.rad(15)
    vessel.input = Input:new()
    setmetatable(vessel, self)
    return vessel
end

function Vessel:handleInput()
    -- Vessel-specific input handling
    if self.input:continuous('forward') then
        self:applyThrust(self.thrust)
    elseif self.input:continuous('backward') then
        self:applyThrust(-self.thrust)
    end

    if self.input:continuous('left_rot') then
        self.rotation = -self.rotation_speed
    elseif self.input:continuous('right_rot') then
        self.rotation = self.rotation_speed
    end
end

function Vessel:update(dt)
    Entity.update(self, dt)
    self:handleInput()
    self:updatePosition(dt)
    print(string.format("[DEBUG-VESSEL] Rotation: %.2f, Angle: %.2f", self.rotation, self.angle))
end

function Vessel:updatePosition(dt)
    -- Update position and apply friction
    self.position = self.position + self.velocity * dt
    self.velocity = self.velocity * self.friction

    -- Update rotation and angle
    self.rotation = self.rotation * self.friction
    self.angle = self.angle + self.rotation * dt
end

function Vessel:applyThrust(thrust)
    -- Calculate forward direction based on ship angle
    local direction = vector(math.cos(self.angle), math.sin(self.angle))
    -- Scale direction with thrust magnitude
    self.velocity = self.velocity + direction * thrust
end

function Vessel:draw()
    -- Save the current transformation
    love.graphics.push()

    -- Translate to the vessel's position and apply rotation
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(self.angle)

    -- Draw the vessel
    if self.sprite then
        love.graphics.draw(self.sprite, -self.width / 2, -self.height / 2)
    end

    -- Highlight the vessel if selected
    if self.selected then
        love.graphics.setColor(colors.green)
        love.graphics.rectangle('line', -self.width / 2, -self.height / 2, self.width, self.height)
        love.graphics.setColor(1, 1, 1)
    end

    -- Draw the hardpoints in the vessel's local space
    for _, hardpoint in ipairs(self.hardpoints) do
        hardpoint:draw({x = 0, y = 0}, 0) -- Local origin and no extra rotation
    end

    -- Restore the previous transformation
    love.graphics.pop()

    -- Draw the target indicator in world space
    if self.target then
        love.graphics.setColor(colors.red)
        love.graphics.line(self.position.x, self.position.y, self.target.x, self.target.y)
        love.graphics.circle('line', self.target.x, self.target.y, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Vessel:addHardpoint(hardpoint)
    table.insert(self.hardpoints, hardpoint)
end

return Vessel
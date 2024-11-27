local Mothership = {}

function Mothership:new(x, y, width, height, max_speed, hardpoints)
    local midX = love.graphics.getWidth() / 2
    local midY = love.graphics.getHeight() / 2
    local obj = {
        x = x or midX,
        y = y or midY,
        width = width or 256,
        height = height or 192,
        speed = 0,
        max_speed = max_speed or 10,
        direction = {x = 0, y = -1}, -- normalized direction vector
        state = 'active',
        target = nil,
        hardpoints = hardpoints or {}
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Mothership:update(dt, input)
    if  self.state == 'active' then
        self:keypressed(input)
    elseif self.state == 'command' then
        self:updateCommand(dt)
    end
    self:updatePosition(dt)
end

function Mothership:keypressed(key)
    if key == 'up' then
        self.direction.y = -1
    elseif key == 'down' then
        self.direction.y = 1
    elseif key == 'left' then
        self.direction.x = -1
    elseif key == 'right' then
        self.direction.x = 1
    else
        self.direction = {x = 0, y = 0}
    end
end

function Mothership:updateCommand(dt)
    if self.target then
        local dx = self.target.x - self.x
        local dy = self.target.y - self.y
        local dist = math.sqrt(dx^2 + dy^2)
        if dist > 1 then
            self.direction.x = dx / dist
            self.direction.y = dy / dist
            self.speed = self.max_speed
        else
            self.direction = {x = 0, y = 0}
            self.speed = 0
        end
    end
end

function Mothership:updatePosition(dt)
    self.x = self.x + self.direction.x * self.speed * dt
    self.y = self.y + self.direction.x * self.speed * dt
end

function Mothership:switchCommand(newState, target)
    self.state = newState
    if newState == 'command' and target then
        self.target = target
    else
        self.target = nil
    end
end

function Mothership:draw()
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

return Mothership
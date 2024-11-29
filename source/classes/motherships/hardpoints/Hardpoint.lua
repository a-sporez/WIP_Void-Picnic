local vector = require('libraries.vector')
local Hardpoint = {}

function Hardpoint:new(type, tier, mount_x, mount_y)
    local obj = {
        type = type or "structure", -- structure > hull > core
        tier = tier or 1, -- 1 to 4
        installed = nil,
        occupied = false,
        mount = vector(mount_x, mount_y)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Hardpoint:installModule(module)
    if not self.occupied then
        if self:canInstall(module) then
            self.installed = module
            return true
        else
            return false, "module incompatible"
        end
    end
end

function Hardpoint:canInstall(module)
    return module.type == self.type and module.tier <= self.tier
end

function Hardpoint:removeModule()
    self.occupied = false
    self.installed = nil
end

function Hardpoint:draw(parentPosition, parentAngle)
    local pos = parentPosition + self.mount:rotated(parentAngle)
    love.graphics.circle('line', pos.x, pos.y, 5)
    if self.module then
        self.module:draw(pos)
    end
end

return Hardpoint
local vector = require('libraries.hump.vector')
local Hardpoint = {}

function Hardpoint:new(name, type, cpu, pwg, mount_x, mount_y, width, height)
    local obj = {
        name = name,
        type = type,
        cpu = cpu,
        pwg = pwg,
        installed = nil,
        occupied = false,
        mount = vector(mount_x, mount_y),
        width = width,
        height = height
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
            return false, "[ERROR-HRDPTS] module incompatible"
        end
    end
end

function Hardpoint:canInstall(module)
    return module.type == self.type
end

function Hardpoint:removeModule()
    self.occupied = false
    self.installed = nil
end

function Hardpoint:draw(parentPosition, parentAngle)
    love.graphics.push()
    local rotatedOffset = self.mount:rotated(parentAngle)
    local pos = parentPosition + rotatedOffset
    print(string.format(
        "[DEBUG-HRDPTS] Hardpoint at: (%.2f, %.2f) | Parent: (%.2f, %.2f) | Offset: (%.2f, %.2f)",
        pos.x, pos.y, parentPosition.x, parentPosition.y, rotatedOffset.x, rotatedOffset.y
    ))
    love.graphics.rectangle('line', pos.x, pos.y, self.width, self.height)
    if self.installed and self.installed.draw then
        self.installed:draw(pos, parentAngle)
    end
    love.graphics.pop()
end

return Hardpoint
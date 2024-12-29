local vector = require('libraries.hump.vector')
local Hardpoint = {}

--[[
TODO: Animation for hardpoint blastdoors
TODO: extend to assign different hardpoint sprites or attributes depending on self.type
--]]

function Hardpoint:new(name, type, cpu, pwg, mount_x, mount_y)
-- Define sprite paths for each type, add new hardpoint types here.
    local sprite_paths = {
        ["8x8"] = 'assets/sprites/hardpoints/8x8_mk1.png',
        ["16x18"] = 'assets/sprites/hardpoints/18x16_mk1.png'
    }

-- Ensure the type has a defined sprite path
    local sprite_path = sprite_paths[type]
    if not sprite_path then
        error("Invalid hardpoint type: " .. tostring(type))
    end

    local sprt = love.graphics.newImage(sprite_path)
-- Create the hardpoint object
    local hardpoint = {
        name = name,
        type = type,
        cpu = cpu,
        pwg = pwg,
        installed = nil,
        occupied = false,
        mount = vector(mount_x, mount_y),
        sprite = sprt,
        width = sprt:getWidth(),
        height = sprt:getHeight()
    }

    setmetatable(hardpoint, self)
    self.__index = self
    return hardpoint
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
--        "[DEBUG-HRDPTS] Hardpoint at: (%.2f, %.2f) | Parent: (%.2f, %.2f) | Offset: (%.2f, %.2f)",
        pos.x, pos.y, parentPosition.x, parentPosition.y, rotatedOffset.x, rotatedOffset.y
    ))
    love.graphics.draw(self.sprite, pos.x, pos.y)
    if self.installed and self.installed.draw then
        self.installed:draw(pos, parentAngle)
    end
    love.graphics.pop()
end

return Hardpoint
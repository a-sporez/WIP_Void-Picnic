-- local love = require('love')

local Hardpoints = {}

function Hardpoints:new(type, tier, mount)
    local hardpoint = {
        type = type or "structure",
        tier = tier or 1,
        installed = nil,
        mount = mount or {x = 0, y = 0},
    }
    setmetatable(hardpoint, self)
    self.__index = self
    return hardpoint
end

function Hardpoints:installModule(module)
    if self:canInstall(module) then
        self.installed = module
        return true
    else
        return false, "module incompatible"
    end
end

function Hardpoints:canInstall(module)
    return module.type == self.type and module.tier <= self.tier
end

function Hardpoints:removeModule()
    self.installed = nil
end

return Hardpoints
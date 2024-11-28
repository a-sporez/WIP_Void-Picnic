local Hardpoint = {}

function Hardpoint:new(type, tier, mount)
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

function Hardpoint:installModule(module)
    if self:canInstall(module) then
        self.installed = module
        return true
    else
        return false, "module incompatible"
    end
end

function Hardpoint:canInstall(module)
    return module.type == self.type and module.tier <= self.tier
end

function Hardpoint:removeModule()
    self.installed = nil
end

return Hardpoint
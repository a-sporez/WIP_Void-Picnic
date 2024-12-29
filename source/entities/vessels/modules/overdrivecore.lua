local Module = require('source.entities.vessels.modules.Module')

local OverdriveCore = {}
OverdriveCore.__index = OverdriveCore
setmetatable(OverdriveCore, {__index = Module})

function OverdriveCore:create(max_flux, flux, vent_rate, x, y, size, mod_type, sprite)
    local obj = Module:new(x, y, 'OverdriveCore', size, mod_type, sprite)
    obj.sprite = sprite or 'path/to/sprite.png' -- Default sprite if none is passed
    obj.max_flux = max_flux or 10000            -- Maximum flux capacity
    obj.flux = flux or 0                        -- Initial flux energy stored
    obj.vent_rate = vent_rate or 10             -- Rate of passive flux venting
    obj.active = false                          -- OverdriveCore active status
    setmetatable(obj, OverdriveCore)            -- Set the metatable to OverdriveCore
    return obj
end

function OverdriveCore:accumulate(flux_rate)
    if self.active then
        self.flux = self.flux + flux_rate
        print(string.format("OverdriveCore Flux: %d/%d", self.flux, self.max_flux))
        if self.flux > self.max_flux then
            self.flux = self.max_flux
            print("Warning: Flux at maximum capacity!")
        end
    end
end

function OverdriveCore:overloaded(threshold)
    threshold = threshold or 0.9 -- Default to 90% if no threshold is passed
    return self.flux >= (self.max_flux * threshold)
end

function OverdriveCore:disassembly()
    if self.flux >= self.max_flux then
        print("OverdriveCore Overload! Systems shutting down...")
        self.active = false
        -- Optional: Damage the ship or trigger an event
        -- Example: reduce_health(self, damage_amount)
    end
end

function OverdriveCore:update(dt)
    self:vent(dt) -- Pass dt to adjust venting by time
    if self:overloaded() then
        print("OverdriveCore Overload Update")
    end
    self:disassembly()
end

function OverdriveCore:vent(dt)
    if not self.active and self.flux > 0 then
        self.flux = self.flux - (self.vent_rate * dt)
        if self.flux < 0 then
            self.flux = 0
        end
    end
end

return OverdriveCore
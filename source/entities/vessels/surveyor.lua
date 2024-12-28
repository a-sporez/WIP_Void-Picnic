local Vessel = require("source.entities.vessels.Vessel")
local Hardpoint = require('source.entities.vessels.hardpoints.Hardpoint')

local Surveyor = {}
Surveyor.__index = Surveyor
setmetatable(Surveyor, {__index = Vessel}) -- inherit from Mothership

-- pass location and size to the hardpoints module
--[[
TODO: contain sprite loading and dimensions in hardpoint and only require type to assign.
--]]
function Surveyor:create(x, y, width, height)
-- name, type, cpu, pwg, mount_x, mount_y, sprite_path
    local hardpoints = {
        Hardpoint:new('front_left', '8x8', 1, 1, 51, -13),
        Hardpoint:new('front_right', '8x8', 1, 1, 51, 5),
        Hardpoint:new('core_left', '16x18', 2, 2, 5, 5),
        Hardpoint:new('core_right', '16x18', 2, 2, 5, -23),
        Hardpoint:new('centre_left', '8x8', 1, 1, -14, -24),
        Hardpoint:new('centre_right', '8x8', 1, 1, -14, 15)
    }

    local hangar = {
        capacity = 10,
        occupied = 0,
        content = {}
    }

    local powergrid = {
        capacity = 10,
        occupied = 0,
    }

    local cpu = {
        capacity = 10,
        occupied = 0,
    }

    local spritePath = 'assets/sprites/motherships/surveyor/surveyor.png'

    local surveyor = Vessel.new(self, x, y, width, height, hardpoints, spritePath)
    surveyor.hangar = hangar
    surveyor.powergrid = powergrid
    surveyor.cpu = cpu
    surveyor.maxSpeed = 100 -- example specific attribute
    surveyor.type = 'Surveyor'
    setmetatable(surveyor, self)
    self.__index = self

--
-- Additional debug print to confirm object initialization
    print("[DEBUG-SRVYR] CPU initialized: capacity = " .. cpu.capacity .. ", occupied = " .. cpu.occupied)
    print("[DEBUG-SRVYR] Powergrid initialized: capacity = " .. powergrid.capacity .. ", occupied = " .. powergrid.occupied)
    print("[DEBUG-SRVYR] Hangar initialized: capacity = " .. hangar.capacity .. ", occupied = " .. hangar.occupied)
    print("[DEBUG-SRVYR] Surveyor created with attributes:")
    print("  Position: (" .. x .. ", " .. y .. ")")
    print("  Hardpoints: " .. #hardpoints)
    print("  Max Speed: " .. surveyor.maxSpeed)
--
    return surveyor
end

function Surveyor:updatePassive(dt)
    print("[DEBUG-SRVYR] Surveyor passive state updating.")
end

function Surveyor:updateCommand(dt)
    print("[DEBUG-SRVYR] Surveyor command state updating.")
end

return Surveyor
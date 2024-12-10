local Vessel = require("source.classes.vessels.Vessel")
local vector = require('libraries.vector')
local Hardpoint = require('source.classes.vessels.hardpoints.Hardpoint')

local Surveyor = {}
Surveyor.__index = Surveyor
setmetatable(Surveyor, {__index = Vessel}) -- inherit from Mothership

function Surveyor:create(x, y, width, height)
-- name, type, cpu, pwg, mount_x, mount_y, width, height
    local hardpoints = {
        Hardpoint:new('front_left', '8x8', 1, 1, 51, -13, 8, 8),
        Hardpoint:new('front_right', '8x8', 1, 1, 51, 5, 8, 8),
        Hardpoint:new('core_left', '16x18', 1, 2, 5, 5, 16, 18),
        Hardpoint:new('core_right', '16x18', 1, 2, 5, -23, 16, 18)
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

    local spritePath = 'assets/sprites/motherships/surveyor/ship1.png'

    local obj = Vessel.new(self, x, y, width, height, hardpoints, spritePath)
    obj.hangar = hangar
    obj.powergrid = powergrid
    obj.cpu = cpu
    obj.maxSpeed = 100 -- example specific attribute
    obj.type = 'Surveyor'
    setmetatable(obj, self)
    self.__index = self

-- Additional debug print to confirm object initialization
    print("[DEBUG] CPU initialized: capacity = " .. cpu.capacity .. ", occupied = " .. cpu.occupied)
    print("[DEBUG] Powergrid initialized: capacity = " .. powergrid.capacity .. ", occupied = " .. powergrid.occupied)
    print("[DEBUG] Hangar initialized: capacity = " .. hangar.capacity .. ", occupied = " .. hangar.occupied)
    print("[DEBUG] Surveyor created with attributes:")
    print("  Position: (" .. x .. ", " .. y .. ")")
    print("  Hardpoints: " .. #hardpoints)
    print("  Max Speed: " .. obj.maxSpeed)

    return obj
end

function Surveyor:updatePassive(dt)
    print("[DEBUG] Surveyor passive state updating.")
end

function Surveyor:updateCommand(dt)
    print("[DEBUG] Surveyor command state updating.")
end

return Surveyor
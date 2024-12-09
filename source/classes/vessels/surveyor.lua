local Vessel = require("source.classes.vessels.Vessel")
local vector = require('libraries.vector')
local Hardpoint = require('source.classes.vessels.hardpoints.Hardpoint')

local Surveyor = {}
Surveyor.__index = Surveyor
setmetatable(Surveyor, {__index = Vessel}) -- inherit from Mothership

function Surveyor:create(x, y, width, height)
    local hardpoints = {
        Hardpoint:new('front_left' ,'8x8', 1, 51, -13, 8, 8),
        Hardpoint:new('front_right' ,'8x8', 1, 51, 5, 8, 8),
        Hardpoint:new('left_core', '16x18', 1, 5, 5, 16, 18),
        Hardpoint:new('right_core', '16x18', 1, 5, -23, 16, 18)
    }

    local spritePath = 'assets/sprites/motherships/surveyor/ship1.png'

    local obj = Vessel.new(self, x, y, width, height, hardpoints, spritePath)
    obj.maxSpeed = 100 -- example specific attribute
    obj.type = 'Surveyor'
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Surveyor:updatePassive(dt)
    print("[DEBUG] Surveyor passive state updating.")
end

function Surveyor:updateCommand(dt)
    print("[DEBUG] Surveyor command state updating.")
end

return Surveyor
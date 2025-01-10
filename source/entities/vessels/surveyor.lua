local Vessel = require('source.entities.vessels.vessel') -- Adjust the path as necessary
local Surveyor = {}
setmetatable(Surveyor, {__index = Vessel}) -- Inherit from Vessel

function Surveyor:create(x, y, width, height)
    -- Define specific hardpoints for Surveyor
    local hardpoints = {
        { name = 'front_left', type = '8x8', cpu = 1, pwg = 1, mount_x = 51, mount_y = -13 },
        { name = 'front_right', type = '8x8', cpu = 1, pwg = 1, mount_x = 51, mount_y = 5 },
        { name = 'core_left', type = '16xs18', cpu = 2, pwg = 2, mount_x = 5, mount_y = 5 },
        { name = 'core_right', type = '16x18', cpu = 2, pwg = 2, mount_x = 5, mount_y = -23 },
        { name = 'centre_left', type = '8x8', cpu = 1, pwg = 1, mount_x = -14, mount_y = -24 },
        { name = 'centre_right', type = '8x8', cpu = 1, pwg = 1, mount_x = -14, mount_y = 15 },
    }

    -- Convert hardpoint definitions to actual objects
    for i, hp in ipairs(hardpoints) do
        hardpoints[i] = require('source.entities.vessels.hardpoints.Hardpoint'):new(hp.name, hp.type, hp.cpu, hp.pwg, hp.mount_x, hp.mount_y)
    end

    local spritePath = 'assets/sprites/motherships/surveyor/surveyor.png'
    local surveyor = Vessel.new(self, x, y, width, height, hardpoints, spritePath) -- Call Vessel constructor

    -- Surveyor-specific attributes
    surveyor.hangar = { capacity = 10, occupied = 0, content = {} }
    surveyor.powergrid = { capacity = 10, occupied = 0 }
    surveyor.cpu = { capacity = 10, occupied = 0 }
    surveyor.maxSpeed = 100
    surveyor.type = 'Surveyor'

    setmetatable(surveyor, self)
    return surveyor
end

function Surveyor:updatePassive(dt)
    -- Placeholder for passive updates
    print("[DEBUG-SURVEYOR] Passive state updating.")
end

function Surveyor:updateCommand(dt)
    -- Placeholder for command-driven updates
    print("[DEBUG-SURVEYOR] Command state updating.")
end

return Surveyor
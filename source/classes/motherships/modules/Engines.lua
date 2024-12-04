local Module = require('source.classes.motherships.modules.Module')

local Engines = {}
Engines.__index = Engines
-- set inheritance from Module
setmetatable(Module, {__index = Module})

function Engines:create()
    
end


return Engines
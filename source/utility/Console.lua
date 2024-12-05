local Console = {}

function Console:new()
    local sprite = love.graphics.newImage('assets/sprites/terminal_1.png')
    local obj = {
        input = "",
        output = "",
        active = false,
        commandHistory = {},
        aliases = {},
        terminal = sprite,
        width = sprite:getWidth(),
        height = sprite:getHeight()
    }
    self.__index = self
    return setmetatable(obj, self)
end

function Console:addAlias(aliasName, command)
    self.aliases[aliasName] = command
    self.output = "Alias '"..aliasName.."' added."
end

function Console:listAliases()
    self.output = "Alias stored: \n"
    for aliasName, command in pairs(self.aliases) do
        self.output = self.output..aliasName.."->"..command.."\n"
    end
end

function Console:processSingleCommand(command)
    print("[DEBUG] Processing Command:"..command)
    local trimmedInput = command:match("^%s*(.-)%s*$")

    if trimmedInput == "clear" then
        self.output = ""
        self.commandHistory = {}
        return
    end

    if self.aliases[command] then
        command = self.aliases[command]
    end
--[[
ADD SINGLE CONSOLE COMMANDS BELOW IN AN IF LOOP
--]]
end

function Console:processCommand(command)
    if string.sub(command, 1, 6) == "alias>" then
        local aliasName, fullCommand = string.match(command, "^alias>(%S+) (.+)$")
        if aliasName and fullCommand then
            self:addAlias(aliasName, fullCommand)
        elseif command == "alias>list" then
            self:listAliases()
        else
            self.output = "Usage: alias>'alias_name' 'command', alias>list"
        end
        return
    end

    -- Split commands by semicolon
    local commands = {}
    for cmd in string.gmatch(command, "([^;]+)") do
        table.insert(commands, cmd:match("^%s*(.-)%s*$"))
    end

    -- Process each command
    for _, cmd in ipairs(commands) do
        if cmd and cmd ~= "" then -- Validate command
            self:processSingleCommand(cmd)
            table.insert(self.commandHistory, 1, cmd)
        end
    end
end

function Console:textinput(key)
    if self.active then self.input = self.input..key end
end

function Console:keypressed(key)
    if self.active then
        if key == 'return' then
            self:processCommand(self.input)
            self.input = ""
        elseif key == 'backspace' then
            self.input = self.input:sub(1, -2)
        elseif key == 'escape' then
            self.active = false
        end
    elseif key == 'return' then
        self.active = not self.active
    end
end

function Console:draw()
    local terminal_x = love.graphics.getWidth() - self.width
    local terminal_y = love.graphics.getHeight() - self.height
    local console_width, console_height = 384, 174
    local text_x, text_y = terminal_x + 20, terminal_y + 32
    local input_scroll = text_x + 1
    local output_scroll = text_x + 384
    local history_scroll = {}

    love.graphics.draw(self.terminal, terminal_x, terminal_y)

    local font = love.graphics.getFont()
-- set scissor for the console area so it only prints within this area.
    love.graphics.setScissor(text_x, text_y, console_width, console_height)
-- scroll console input if is exceeds the width of the area
    local input_width = font:getWidth(self.input)
    if input_width > console_width then
        input_scroll = input_width - console_width
    else
        input_scroll = 0
    end
-- print console input line with ">" as visible cue
    if self.active then
        love.graphics.print(">"..self.input, text_x - input_scroll, text_y)
    end
-- scroll console output if it exceeds the width of the area
    if self.output ~= "" then
        local output_width = font:getWidth(">"..self.output)
        if output_width > console_width then
            output_scroll = output_width - console_width
        else
            output_scroll = 0
        end
        love.graphics.print(
            ">"..self.output, text_x - output_scroll, text_y + 22)
    end

    for i, command in ipairs(self.commandHistory) do
        local history_width = font:getWidth(">"..command)
        if history_width > console_width then
            history_scroll[i] = history_width - console_width
        else
            history_scroll[i] = 0
        end
        love.graphics.print(
            ">"..command, text_x - (history_scroll[i] or 0), text_y + 22 * (i + 1))
    end

    love.graphics.setScissor()
    love.graphics.setColor(1, 1, 1)

end

return Console
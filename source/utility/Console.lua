local Console = {
    input = "",
    output = "",
    active = false,
    commandHistory = {},
    aliases = {}
}

function Console.addAlias(aliasName, command)
    Console.aliases[aliasName] = command
    Console.output = "Alias '"..aliasName.."' added."
end

function Console.listAliases()
    Console.output = "Alias stored: \n"
    for aliasName, command in pairs(Console.aliases) do
        Console.output = Console.output..aliasName.."->"..command.."\n"
    end
end

function Console.processSingleCommand(command)
    print("Processing Command:"..command)
    local trimmedInput = command:match("^%s*(.-)%s*$")

    if Console.aliases[command] then
        command = Console.aliases[command]
    end
--[[
ADD SINGLE CONSOLE COMMANDS BELOW IN AN IF LOOP
--]]
end

function Console.processCommand(command)
    if string.sub(command, 1, 6) == "alias>" then
        local aliasName, fullCommand = string.match(command, "^alias>(%S+) (.+)$")
        if aliasName and fullCommand then
            Console.addAlias(aliasName, fullCommand)
        elseif command == "alias>list" then
            Console.output = "Usage: alias>'alias_name' 'command', alias>list"
        end
        return
    end

    local commands = {}
    for _, command in string.gmatch(command, "([^;]+)") do
        table.insert(commands, command:match("^%s*(.-%s*$)"))
    end

    for _, command in ipairs(commands) do
        Console.processSingleCommand(command)
        table.insert(Console.commandHistory, 1)
    end
end

function Console.textinput(key)
    if Console.active then Console.input = Console.input..key end
end

function Console.keypressed(key)
    if Console.active then
        if key == 'return' then
            Console.processCommand(Console.input)
            Console.input = ""
        elseif key == 'backspace' then
            Console.input = Console.input:sub(1, -2)
        elseif key == 'escape' then
            Console.active = false
        end
    elseif key == key then
        Console.active = true
    end
end

function Console.draw()
    -- TODO: draw terminal here.
end
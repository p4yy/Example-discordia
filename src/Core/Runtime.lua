local Json = require("../Dependencies/Json.lua")
local EventHandlers = require("../Dependencies/EventHandlers.lua")
local Utils = require("../Dependencies/Utils.lua")

local Runtime = {
    Data = {}, 
    DataFiles = {"Settings", "Event", "Userdata"}
}

function Runtime.WriteGTFile(Path,Text)
    Content = Json.encode(Text)
    Utils.WriteFile(Path,Content)
end

function Runtime.ReadGTFile(Path)
    return Json.decode(Utils.ReadFile(Path))
end

function Runtime.ReadFile(Path)
    return Utils.ReadFile(Path)
end

function Runtime.LoadJsonFiles()
    for _, DataFileName in pairs(Runtime.DataFiles) do
        local DataFile = io.open(string.format("src/Data/%s.json", DataFileName))
        local Content = DataFile:read("*a")

        Runtime.Data[DataFileName] = Json.decode(Content)

        DataFile:close()
    end
end

function Runtime.HandleEvents(Client)
    for Event, Handler in pairs(EventHandlers) do
        local Alias = Runtime.Data.Event[Event]
        if type(Handler) == "function" and Alias then
            Client:on(Alias, function(...)
                if Alias == "ready" then
                    local Content = Utils.ReadFile("src/Data/Userdata.json")
                    Content = Json.decode(Content)
                    Content.BotName = Client.user.username
                    Content = Json.encode(Content)
                    Utils.WriteFile("src/Data/Userdata.json", Content)
                    Runtime.LoadJsonFiles()
                end
                return Handler(Runtime, ...)
            end)
        end
    end
end

function Runtime.RunBot(Client)
    Client:run(string.format("Bot %s", Runtime.Data.Settings.token))
end

return Runtime
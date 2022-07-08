local Events = {}

function LoadBotVar(Bot,Who_Run,ignore)
    if Who_Run == "bot1" then
        if ignore == "autobreak" then
            Bot.bot1.gt_bool_autobreak = Bot.bot1.gt_bool_autobreak
            Bot.bot1.gt_bool_placebreak = false
            Bot.bot1.gt_bool_autoplant = false
            Bot.bot1.gt_bool_autoharvest = false
        elseif ignore == "placebreak" then
            Bot.bot1.gt_bool_autobreak = false
            Bot.bot1.gt_bool_placebreak = Bot.bot1.gt_bool_placebreak
            Bot.bot1.gt_bool_autoplant = false
            Bot.bot1.gt_bool_autoharvest = false
        elseif ignore == "autoplant" then
            Bot.bot1.gt_bool_autobreak = false
            Bot.bot1.gt_bool_placebreak = false
            Bot.bot1.gt_bool_autoplant = Bot.bot1.gt_bool_autoplant
            Bot.bot1.gt_bool_autoharvest = false
        elseif ignore == "autoharvest" then
            Bot.bot1.gt_bool_autobreak = false
            Bot.bot1.gt_bool_placebreak = false
            Bot.bot1.gt_bool_autoplant = false
            Bot.bot1.gt_bool_autoharvest = Bot.bot1.gt_bool_autoharvest
        else
            Bot.bot1.gt_bool_autobreak = false
            Bot.bot1.gt_bool_placebreak = false
            Bot.bot1.gt_bool_autoplant = false
            Bot.bot1.gt_bool_autoharvest = false
        end
        Bot.bot1.gt_changebot[1] = false
        Bot.bot1.gt_warp[1] = false
        Bot.bot1.gt_gotile[1] = false
        Bot.bot1.gt_collect[1] = false
        Bot.bot1.gt_bool_upgradebp = false
        Bot.bot1.gt_bool_do_connect = false
        Bot.bot1.gt_wear[1] = false
        Bot.bot1.gt_drop[1] = false
        Bot.bot1.gt_bool_autoacc = false
        Bot.bot1.change_config = false
        Bot.bot1.gt_bool_reset = false
    elseif Who_Run == "bot2" then
        if ignore == "autobreak" then
            Bot.bot2.gt_bool_autobreak = Bot.bot2.gt_bool_autobreak
            Bot.bot2.gt_bool_placebreak = false
            Bot.bot2.gt_bool_autoplant = false
            Bot.bot2.gt_bool_autoharvest = false
        elseif ignore == "placebreak" then
            Bot.bot2.gt_bool_autobreak = false
            Bot.bot2.gt_bool_placebreak = Bot.bot2.gt_bool_placebreak
            Bot.bot2.gt_bool_autoplant = false
            Bot.bot2.gt_bool_autoharvest = false
        elseif ignore == "autoplant" then
            Bot.bot2.gt_bool_autobreak = false
            Bot.bot2.gt_bool_placebreak = false
            Bot.bot2.gt_bool_autoplant = Bot.bot2.gt_bool_autoplant
            Bot.bot2.gt_bool_autoharvest = false
        elseif ignore == "autoharvest" then
            Bot.bot2.gt_bool_autobreak = false
            Bot.bot2.gt_bool_placebreak = false
            Bot.bot2.gt_bool_autoplant = false
            Bot.bot2.gt_bool_autoharvest = Bot.bot2.gt_bool_autoharvest
        else
            Bot.bot2.gt_bool_autobreak = false
            Bot.bot2.gt_bool_placebreak = false
            Bot.bot2.gt_bool_autoplant = false
            Bot.bot2.gt_bool_autoharvest = false
        end
        Bot.bot2.gt_changebot[1] = false
        Bot.bot2.gt_warp[1] = false
        Bot.bot2.gt_gotile[1] = false
        Bot.bot2.gt_collect[1] = false
        Bot.bot2.gt_bool_upgradebp = false
        Bot.bot2.gt_bool_do_connect = false
        Bot.bot2.gt_wear[1] = false
        Bot.bot2.gt_drop[1] = false
        Bot.bot2.gt_bool_autoacc = false
        Bot.bot2.change_config = false
        Bot.bot2.gt_bool_reset = false
    end
end

function Events.OnReady(_)
    print("Bot is ready!")
end

function Events.OnMessageSent(Runtime, Message)
    local Content = Message.content
    local ChannelName = Message.channel.name
    local isCommand = Message.content:sub(1,1) == Runtime.Data.Settings.prefix
    local bool_ResetConfigGrowtopia = {false, false}

    if not isCommand then
        return
    end

    Content = Content:sub(2)
    local isOwner = false
    for _, Owner in pairs(Runtime.Data.Userdata.OwnerName) do
        if Owner == Message.author.name then
            isOwner = true
            break
        end
    end
    if not isOwner then
        return
    end

    if Content == "help" then
        if Message.channel.name == "help" then
            Message:reply("```"..
                "!infobot1 --> Print information\n\n"..
                "!resetbot1 --> Reset configuration\n\n"..
                "!command bot1 autobreak --> Run autobreak\n\n"..
                "!command bot1 autobreakclash --> Run autobreak for clash event\n\n"..
                "!command bot1 placebreak --> Run placebreak\n\n"..
                "!command bot1 autoharvest{world1,world2,world3} --> Run autoharvest\n\n"..
                "!command bot1 autoplant{world1,world2,world3} --> Run autoplant\n\n"..
                "!command bot1 changebot{username,password} --> Change BOT1 to other account\n\n"..
                "!command bot1 warp payy --> Warp bot1 to world payy\n\n"..
                "!command bot1 gotile{68,24} --> Move to coordinate 68,24\n\n"..
                "!command bot1 collect{2} --> Collect item range(2)\n\n"..
                "!command bot1 connect\n\n"..
                "!command bot1 wear{126} --> wear itemID(126)\n\n"..
                "!command bot1 drop{340} --> drop itemID(340)\n\n"..
                "!command bot1 acc\n\n"..
                "!command bot1 upgradebp --> upgrade backpack\n\n"..
                "!configitemid 5666 --> set itemID\n\n"..
                "!configstorage myworld --> set storage\n\n"..
                "!configsolo true/false --> set bool_solo\n\n"..
                "!command showconfig\n\n"..
                "!screenshot\n\n"..
                "!usage --> show cpu usage & memory usage\n\n"..
            "```")
            return
        end
    elseif Content == "usage" and ChannelName == "command" then
        local contentUsage = Runtime.ReadFile("ahk/payy_cpu.txt")
        Message:reply("```"..contentUsage.."```")
    elseif Content == "screenshot" and ChannelName == "command" then
        Message:reply{
            file = "ahk/screen.png"
        }
    elseif Content == "showconfig" and ChannelName == "command" then
        local Bot1 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        local Bot2 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")

        local ContentBot1 =
            "itemID : "..Bot1.bot1.config.itemID..
            "\nstorage : "..Bot1.bot1.config.storage..
            "\nbool_solo : "..tostring(Bot1.bot1.config.bool_solo)

        local ContentBot2 =
            "itemID : "..Bot2.bot2.config.itemID..
            "\nstorage : "..Bot2.bot2.config.storage..
            "\nbool_solo : "..tostring(Bot2.bot2.config.bool_solo)

        Message:reply{
            embed = {
              title = "CONFIG",
              fields = {                {
                    name = "BOT 1", 
                    value = ContentBot1,
                    inline = false
                },
                {
                    name = "BOT 2", 
                    value = ContentBot2,
                    inline = false
                }
              }
            }
        }
    elseif Content == "info" and ChannelName == "command" then
        local Bot1 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        local Bot2 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")

        local ContentBot1 =
            "USERNAME : "..Bot1.bot1.gt_username..
            "\nLEVEL : ".."ERROR".. --..Bot.bot1.gt_bot_level..
            "\nWORLD : "..Bot1.bot1.gt_world_join..
            "\nCOORDINATE : X"..Bot1.bot1.gt_current_coord[1]..", Y"..Bot1.bot1.gt_current_coord[2]..
            "\nSTATUS : "..Bot1.bot1.gt_status_bot..
            "\nGEMS : "..Bot1.bot1.gt_inventory_gems..
            "\nAUTOBREAK : "..tostring(Bot1.bot1.gt_bool_autobreak)..
            "\nPLACEBREAK : "..tostring(Bot1.bot1.gt_bool_placebreak)..
            "\nAUTOHARVEST : "..tostring(Bot1.bot1.gt_bool_autoharvest)..
            "\nAUTOPLANT : "..tostring(Bot1.bot1.gt_bool_autoplant)..
            "\nRESET : "..tostring(Bot1.bot1.gt_bool_reset)..
            "\nLOGS : "..Bot1.bot1.gt_logs

        local ContentBot2 =
            "USERNAME : "..Bot2.bot2.gt_username..
            "\nLEVEL : ".."ERROR".. --..Bot.bot1.gt_bot_level..
            "\nWORLD : "..Bot2.bot2.gt_world_join..
            "\nCOORDINATE : X"..Bot2.bot2.gt_current_coord[1]..", Y"..Bot2.bot2.gt_current_coord[2]..
            "\nSTATUS : "..Bot2.bot2.gt_status_bot..
            "\nGEMS : "..Bot2.bot2.gt_inventory_gems..
            "\nAUTOBREAK : "..tostring(Bot2.bot2.gt_bool_autobreak)..
            "\nPLACEBREAK : "..tostring(Bot2.bot2.gt_bool_placebreak)..
            "\nAUTOHARVEST : "..tostring(Bot2.bot2.gt_bool_autoharvest)..
            "\nAUTOPLANT : "..tostring(Bot2.bot2.gt_bool_autoplant)..
            "\nRESET : "..tostring(Bot2.bot2.gt_bool_reset)..
            "\nLOGS : "..Bot2.bot2.gt_logs

        Message:reply{
            embed = {
              title = "INFO",
              fields = {                {
                    name = "BOT 1", 
                    value = ContentBot1,
                    inline = false
                },
                {
                    name = "BOT 2", 
                    value = ContentBot2,
                    inline = false
                }
              }
            }
        }
    elseif Content == "resetbot1" and ChannelName == "command" then
        bool_ResetConfigGrowtopia[1] = true
    elseif Content == "resetbot2" and ChannelName == "command" then
        bool_ResetConfigGrowtopia[2] = true
    elseif Content == "infobot1" and ChannelName == "command" then
        local Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        Message:reply("```INFO : BOT1\n"..
            "USERNAME : "..Bot.bot1.gt_username..
            "\nLEVEL : ".."ERROR".. --..Bot.bot1.gt_bot_level..
            "\nWORLD : "..Bot.bot1.gt_world_join..
            "\nCOORDINATE : X"..Bot.bot1.gt_current_coord[1]..", Y"..Bot.bot1.gt_current_coord[2]..
            "\nSTATUS : "..Bot.bot1.gt_status_bot..
            "\nGEMS : "..Bot.bot1.gt_inventory_gems..
            "\nAUTOBREAK : "..tostring(Bot.bot1.gt_bool_autobreak)..
            "\nPLACEBREAK : "..tostring(Bot.bot1.gt_bool_placebreak)..
            "\nAUTOHARVEST : "..tostring(Bot.bot1.gt_bool_autoharvest)..
            "\nAUTOPLANT : "..tostring(Bot.bot1.gt_bool_autoplant)..
            "\nRESET : "..tostring(Bot.bot1.gt_bool_reset)..
            "\nLOGS : "..Bot.bot1.gt_logs..
            "```")
    elseif Content == "infobot2" and ChannelName == "command" then
        local Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
        Message:reply("```INFO : BOT2\n"..
            "USERNAME : "..Bot.bot2.gt_username..
            "\nLEVEL : ".."ERROR"..--Bot.bot2.gt_bot_level..
            "\nWORLD : "..Bot.bot2.gt_world_join..
            "\nCOORDINATE : X"..Bot.bot2.gt_current_coord[1]..", Y"..Bot.bot2.gt_current_coord[2]..
            "\nSTATUS : "..Bot.bot2.gt_status_bot..
            "\nGEMS : "..Bot.bot2.gt_inventory_gems..
            "\nAUTOBREAK : "..tostring(Bot.bot2.gt_bool_autobreak)..
            "\nPLACEBREAK : "..tostring(Bot.bot2.gt_bool_placebreak)..
            "\nAUTOHARVEST : "..tostring(Bot.bot2.gt_bool_autoharvest)..
            "\nAUTOPLANT : "..tostring(Bot.bot2.gt_bool_autoplant)..
            "\nRESET : "..tostring(Bot.bot2.gt_bool_reset)..
            "\nLOGS : "..Bot.bot2.gt_logs..
            "```")
    elseif Content:find("configitemid") ~= nil and ChannelName == "command" then
       if Message.content:sub(2,13) ~= "configitemid" or Message.content:sub(14,14) ~= " " then
            return
       end
       local Bot1 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
       local Bot2 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
       local itemID = tonumber(Message.content:sub(15))
       Bot1.bot1.config.itemID = itemID
       Bot2.bot2.config.itemID = itemID
       Bot1.bot1.change_config = true
       Bot2.bot2.change_config = true
       Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot1.json",Bot1)
       Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot2.json",Bot2)
       Message:reply("```Change itemID to "..itemID.."```")
    elseif Content:find("configstorage") ~= nil and ChannelName == "command" then
        if Message.content:sub(2,14) ~= "configstorage" or Message.content:sub(15,15) ~= " " then
            return
        end
        local Bot1 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        local Bot2 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
        local storage = Message.content:sub(16)
        Bot1.bot1.config.storage = storage
        Bot2.bot2.config.storage = storage
        Bot1.bot1.change_config = true
        Bot2.bot2.change_config = true
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot1.json",Bot1)
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot2.json",Bot2)
        Message:reply("```Change storage to "..storage.."```")
    elseif Content:find("configsolo") ~= nil and ChannelName == "command" then
        if Message.content:sub(2,11) ~= "configsolo" or Message.content:sub(12,12) ~= " " or 
                (Message.content:sub(13) ~= "true" and Message.content:sub(13) ~= "false") then
            return
        end
        local Bot1 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        local Bot2 = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
        local solo = Message.content:sub(13)
        if solo == "true" then
            Bot1.bot1.config.bool_solo = true
            Bot2.bot2.config.bool_solo = true
            Bot1.bot1.change_config = true
            Bot2.bot2.change_config = true
        elseif solo == "false" then
            Bot1.bot1.config.bool_solo = false
            Bot2.bot2.config.bool_solo = false
            Bot1.bot1.change_config = true
            Bot2.bot2.change_config = true
        end
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot1.json",Bot1)
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot2.json",Bot2)
        Message:reply("```Config bool_solo "..solo.."```")
    elseif Content:find("command") ~= nil and ChannelName == "command" then
        if Message.content:sub(9,9) ~= " " and Message.content:sub(14,14) ~= " " then
            return
        end
        local GT_Command = Message.content:sub(15)
        local Who_Run = Message.content:sub(10,13)
        if Who_Run == "bot1" then
            local Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
            if GT_Command == "autobreak" then
                LoadBotVar(Bot,Who_Run,"autobreak")
                Bot.bot1.gt_bool_autobreak = not Bot.bot1.gt_bool_autobreak
                Bot.bot1.setting.setting_autobreak.clash = false
                Message:reply("```SET AUTOBREAK BOT1 \nNAME --> "..Bot.bot1.gt_username.."\nAUTOBREAK --> "..tostring(Bot.bot1.gt_bool_autobreak).."```")
            elseif GT_Command == "autobreakclash" then
                LoadBotVar(Bot,Who_Run,"autobreak")
                Bot.bot1.gt_bool_autobreak = not Bot.bot1.gt_bool_autobreak
                Bot.bot1.setting.setting_autobreak.clash = true
                Message:reply("```SET AUTOBREAKCLASH BOT1 \nNAME --> "..Bot.bot1.gt_username.."\nAUTOBREAK --> "..tostring(Bot.bot1.gt_bool_autobreak).."```")
            elseif GT_Command == "placebreak" then
                LoadBotVar(Bot,Who_Run,"placebreak")
                Bot.bot1.gt_bool_placebreak = not Bot.bot1.gt_bool_placebreak
                Message:reply("```SET PLACEBREAK BOT1 \nNAME --> "..Bot.bot1.gt_username.."\nPLACEBREAK --> "..tostring(Bot.bot1.gt_bool_placebreak).."```")
            elseif GT_Command:find("changebot{") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_changebot[1] = true
                Bot.bot1.gt_changebot[2] = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find(",")-1)
                Bot.bot1.gt_changebot[3] = GT_Command:sub(GT_Command:find(",")+1, GT_Command:find("}")-1)
                Message:reply("```CHANGE BOT1 TO --> \nUSERNAME:"..Bot.bot1.gt_changebot[2].."\nPASSWORD:"..Bot.bot1.gt_changebot[3].."```")
            elseif GT_Command:find("warp") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_warp[1] = true
                Bot.bot1.gt_warp[2] = Message.content:sub(20)
                Message:reply("```Warp BOT1\nName : "..Bot.bot1.gt_username.."\nDestination : "..Bot.bot1.gt_warp[2].."```")
            elseif GT_Command:find("gotile") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_gotile[1] = true
                Bot.bot1.gt_gotile[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find(",")-1))
                Bot.bot1.gt_gotile[3] = tonumber(GT_Command:sub(GT_Command:find(",")+1, GT_Command:find("}")-1))
                local beforeMoveCoordBot = {Bot.bot1.gt_current_coord[1],Bot.bot1.gt_current_coord[2]}
                Message:reply("```MOVE "..Bot.bot1.gt_username.." FROM \nCOORDINATE : {"..beforeMoveCoordBot[1]..","..beforeMoveCoordBot[2].."} TO\n"..
                "COORDINATE : {"..Bot.bot1.gt_gotile[2]..","..Bot.bot1.gt_gotile[3].."}```")
            elseif GT_Command:find("collect") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_collect[1] = true
                Bot.bot1.gt_collect[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot1.gt_username.." Collect("..Bot.bot1.gt_collect[2]..")```")
            elseif GT_Command:find("wear") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_wear[1] = true
                Bot.bot1.gt_wear[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot1.gt_username.." Wear("..Bot.bot1.gt_wear[2]..")```")
            elseif GT_Command:find("drop") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_drop[1] = true
                Bot.bot1.gt_drop[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot1.gt_username.." Drop("..Bot.bot1.gt_drop[2]..")```")
            elseif GT_Command == "connect" then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_bool_do_connect = true
                Message:reply("```Connect "..Bot.bot1.gt_username.." "..tostring(Bot.bot1.gt_bool_do_connect).."```")
            elseif GT_Command:find("acc") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_bool_autoacc = true
                Message:reply("```Auto access lock "..Bot.bot1.gt_username.." "..tostring(Bot.bot1.gt_bool_autoacc).."```")
            elseif GT_Command:find("autoharvest") ~= nil then
                LoadBotVar(Bot,Who_Run,"autoharvest")
                Bot.bot1.gt_bool_autoharvest = not Bot.bot1.gt_bool_autoharvest
                Bot.bot1.gt_autoharvest_world = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1)
                Message:reply("```SET AUTOHARVEST BOT1 \nNAME --> "..Bot.bot1.gt_username.."\nAUTOHARVEST --> "..tostring(Bot.bot1.gt_bool_autoharvest).."\nWORLD --> "..Bot.bot1.gt_autoharvest_world.."```")
            elseif GT_Command:find("autoplant") ~= nil then
                LoadBotVar(Bot,Who_Run,"autoplant")
                Bot.bot1.gt_bool_autoplant = not Bot.bot1.gt_bool_autoplant
                Bot.bot1.gt_autoplant_world = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1)
                Message:reply("```SET AUTOPLANT BOT1 \nNAME --> "..Bot.bot1.gt_username.."\nAUTOPLANT --> "..tostring(Bot.bot1.gt_bool_autoplant).."\nWORLD --> "..Bot.bot1.gt_autoplant_world.."```")
            elseif GT_Command == "upgradebp" then
                LoadBotVar(Bot,Who_Run)
                Bot.bot1.gt_bool_upgradebp = true
                Message:reply("```Upgrade Backpack "..Bot.bot1.gt_username.."```")
            end
            Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot1.json",Bot)
        elseif Who_Run == "bot2" then
            local Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
            if GT_Command == "autobreak" then
                LoadBotVar(Bot,Who_Run,"autobreak")
                Bot.bot2.gt_bool_autobreak = not Bot.bot2.gt_bool_autobreak
                Bot.bot2.setting.setting_autobreak.clash = false
                Message:reply("```SET AUTOBREAK BOT2 \nNAME --> "..Bot.bot2.gt_username.."\nAUTOBREAK --> "..tostring(Bot.bot2.gt_bool_autobreak).."```")
            elseif GT_Command == "autobreakclash" then
                LoadBotVar(Bot,Who_Run,"autobreak")
                Bot.bot2.gt_bool_autobreak = not Bot.bot2.gt_bool_autobreak
                Bot.bot2.setting.setting_autobreak.clash = true
                Message:reply("```SET AUTOBREAKCLASH BOT2 \nNAME --> "..Bot.bot2.gt_username.."\nAUTOBREAK --> "..tostring(Bot.bot2.gt_bool_autobreak).."```")
            elseif GT_Command == "placebreak" then
                LoadBotVar(Bot,Who_Run,"placebreak")
                Bot.bot2.gt_bool_placebreak = not Bot.bot2.gt_bool_placebreak
                Message:reply("```SET PLACEBREAK BOT2 \nNAME --> "..Bot.bot2.gt_username.."\nPLACEBREAK --> "..tostring(Bot.bot2.gt_bool_placebreak).."```")
            elseif GT_Command:find("changebot{") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_changebot[1] = true
                Bot.bot2.gt_changebot[2] = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find(",")-1)
                Bot.bot2.gt_changebot[3] = GT_Command:sub(GT_Command:find(",")+1, GT_Command:find("}")-1)
                Message:reply("```CHANGE BOT2 TO --> \nUSERNAME:"..Bot.bot2.gt_changebot[2].."\nPASSWORD:"..Bot.bot2.gt_changebot[3].."```")
            elseif GT_Command:find("warp") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_warp[1] = true
                Bot.bot2.gt_warp[2] = Message.content:sub(20)
                Message:reply("```Warp BOT2\nName : "..Bot.bot2.gt_username.."\nDestination : "..Bot.bot2.gt_warp[2].."```")
            elseif GT_Command:find("gotile") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_gotile[1] = true
                Bot.bot2.gt_gotile[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find(",")-1))
                Bot.bot2.gt_gotile[3] = tonumber(GT_Command:sub(GT_Command:find(",")+1, GT_Command:find("}")-1))
                local beforeMoveCoordBot = {Bot.bot2.gt_current_coord[1],Bot.bot2.gt_current_coord[2]}
                Message:reply("```MOVE "..Bot.bot2.gt_username.." FROM \nCOORDINATE : {"..beforeMoveCoordBot[1]..","..beforeMoveCoordBot[2].."} TO\n"..
                "COORDINATE : {"..Bot.bot2.gt_gotile[2]..","..Bot.bot2.gt_gotile[3].."}```")
            elseif GT_Command:find("collect") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_collect[1] = true
                Bot.bot2.gt_collect[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot2.gt_username.." Collect("..Bot.bot2.gt_collect[2]..")```")
            elseif GT_Command:find("wear") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_wear[1] = true
                Bot.bot2.gt_wear[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot2.gt_username.." Wear("..Bot.bot2.gt_wear[2]..")```")
            elseif GT_Command:find("drop") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_drop[1] = true
                Bot.bot2.gt_drop[2] = tonumber(GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1))
                Message:reply("```"..Bot.bot2.gt_username.." Drop("..Bot.bot2.gt_drop[2]..")```")
            elseif GT_Command == "connect" then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_bool_do_connect = true
                Message:reply("```Connect "..Bot.bot2.gt_username.." "..tostring(Bot.bot2.gt_bool_do_connect).."```")
            elseif GT_Command:find("acc") ~= nil then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_bool_autoacc = true
                Message:reply("```Auto access lock "..Bot.bot2.gt_username.." "..tostring(Bot.bot2.gt_bool_autoacc).."```")
            elseif GT_Command:find("autoharvest") ~= nil then
                LoadBotVar(Bot,Who_Run,"autoharvest")
                Bot.bot2.gt_bool_autoharvest = not Bot.bot2.gt_bool_autoharvest
                Bot.bot2.gt_autoharvest_world = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1)
                Message:reply("```SET AUTOHARVEST BOT2 \nNAME --> "..Bot.bot2.gt_username.."\nAUTOHARVEST --> "..tostring(Bot.bot2.gt_bool_autoharvest).."\nWORLD --> "..Bot.bot2.gt_autoharvest_world.."```")
            elseif GT_Command:find("autoplant") ~= nil then
                LoadBotVar(Bot,Who_Run,"autoplant")
                Bot.bot2.gt_bool_autoplant = not Bot.bot2.gt_bool_autoplant
                Bot.bot2.gt_autoplant_world = GT_Command:sub(GT_Command:find("{")+1, GT_Command:find("}")-1)
                Message:reply("```SET AUTOPLANT BOT2 \nNAME --> "..Bot.bot2.gt_username.."\nAUTOPLANT --> "..tostring(Bot.bot2.gt_bool_autoplant).."\nWORLD --> "..Bot.bot2.gt_autoplant_world.."```")
            elseif GT_Command == "upgradebp" then
                LoadBotVar(Bot,Who_Run)
                Bot.bot2.gt_bool_upgradebp = true
                Message:reply("```Upgrade Backpack "..Bot.bot2.gt_username.."```")
            end
            Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot2.json",Bot)
        end
    end
    if bool_ResetConfigGrowtopia[1] then
        Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot1.json")
        LoadBotVar(Bot,"bot1")
        Bot.bot1.gt_bool_reset = true
        Bot.bot1.gt_bool_autobreak = false
        Bot.bot1.gt_bool_placebreak = false
        Bot.bot1.gt_bool_autoplant = false
        Bot.bot1.gt_bool_autoharvest = false
        Bot.bot1.setting.setting_autobreak.clash = false
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot1.json",Bot)
        bool_ResetConfigGrowtopia[1] = false
        Message:reply("```RESET BOT1```")
    end
    if bool_ResetConfigGrowtopia[2] then
        Bot = Runtime.ReadGTFile("src/Data/ConfigGrowtopiaBot2.json")
        LoadBotVar(Bot,"bot2")
        Bot.bot2.gt_bool_reset = true
        Bot.bot2.gt_bool_autobreak = false
        Bot.bot2.gt_bool_placebreak = false
        Bot.bot2.gt_bool_autoplant = false
        Bot.bot2.gt_bool_autoharvest = false
        Bot.bot2.setting.setting_autobreak.clash = false
        Runtime.WriteGTFile("src/Data/ConfigGrowtopiaBot2.json",Bot)
        bool_ResetConfigGrowtopia[2] = false
        Message:reply("```RESET BOT2```")
    end
end

return Events
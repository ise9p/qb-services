local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('police:server:servicescheck', function(source, cb, playerCitiz, ischeck)
    local Player = QBCore.Functions.GetPlayer(source)
    local Player2 = QBCore.Functions.GetPlayerByCitizenId(playerCitiz)
    local status = ""
    if Player2 ~= nil then
        cb(Player2.PlayerData.metadata["isstopservices"])
        if ischeck then
            if Player2.PlayerData.metadata["isstopservices"] then status = "Disabled" else status = "Enabled" end
            TriggerEvent("qb-log:server:CreateLog", "stopservices", "Checked service suspension | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :Checked citizen's services** \n **Service status: "..status.."**", false)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Invalid citizen ID!", 'error')
    end
end)

RegisterServerEvent('police:server:manageservices', function(playerCitiz, istrue)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local Player2 = QBCore.Functions.GetPlayerByCitizenId(playerCitiz)
    local status = ""
    if istrue then
        Player2.Functions.SetMetaData("isstopservices", true)
        TriggerClientEvent('QBCore:Notify', Player2.PlayerData.source, "Your services have been suspended by the police", 'success')
        TriggerClientEvent('QBCore:Notify', src, Player2.PlayerData.charinfo.firstname .. " " .. Player2.PlayerData.charinfo.lastname .. " citizen's services have been suspended", 'success')
        status = "Disabled"
        TriggerEvent("qb-log:server:CreateLog", "stopservices", "Suspended citizen services | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :Citizen's services suspended** \n **Service status: "..status.."**", false)
    else
        Player2.Functions.SetMetaData("isstopservices", false)
        TriggerClientEvent('QBCore:Notify', Player2.PlayerData.source, "Your services have been reinstated by the police", 'success')
        TriggerClientEvent('QBCore:Notify', src, Player2.PlayerData.charinfo.firstname .. " " .. Player2.PlayerData.charinfo.lastname .. " citizen's services have been reinstated", 'success')
        status = "Enabled"
        TriggerEvent("qb-log:server:CreateLog", "stopservices", "Reinstated citizen services | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :Citizen's services reinstated** \n **Service status: "..status.."**", false)
    end
end)

QBCore.Functions.CreateCallback('qb-stopservices:server:servicescheck', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    cb(Player.PlayerData.metadata["isstopservices"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

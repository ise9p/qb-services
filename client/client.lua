local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("playerservices", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job and PlayerData.job.name == Config.Job then
        TriggerEvent('police:client:playerservices')
    else
        QBCore.Functions.Notify("This command is for " .. Config.Job .. " only!", "error")
    end
end, false)

RegisterNetEvent('police:client:playerservices', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local playerName = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname

    if Config.menu == "qb" then
        local officerdetails = {
            {
                header = "Citizen Services",
                isMenuHeader = true,
                icon = "fas fa-user-shield"
            },
            {
                header = "Welcome, " .. playerName,
                isMenuHeader = true,
                txt = "Player's name",
                icon = "fas fa-user"
            },
            {
                header = "Check Services",
                txt = "Check if the services are active or not",
                params = {
                    event = "police:client:checkservices"
                },
                icon = "fas fa-search"
            },
            {
                header = "Deactivate Services",
                txt = "Deactivate a specific citizen's services",
                params = {
                    event = "police:client:manageservices",
                    args = { status = true }
                },
                icon = "fas fa-user-slash"
            },
            {
                header = "Reactivate Services",
                txt = "Reactivate a specific citizen's services",
                params = {
                    event = "police:client:manageservices",
                    args = { status = false }
                },
                icon = "fas fa-user-check"
            },
            {
                header = "Exit",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                },
                icon = "fas fa-times"
            },
        }
        exports['qb-menu']:openMenu(officerdetails)
    elseif Config.menu == "ox" then
        local officerdetails = {
            {
                title = "Citizen Services",
                icon = "fa-solid fa-user-shield",
                disabled = true
            },
            {
                title = "Welcome, " .. playerName,
                description = "Player's name",
                icon = "fa-solid fa-user",
                disabled = true
            },
            {
                title = "Check Services",
                description = "Check if the services are active or not",
                icon = "fa-solid fa-search",
                onSelect = function()
                    TriggerEvent("police:client:checkservices")
                end
            },
            {
                title = "Deactivate Services",
                description = "Deactivate a specific citizen's services",
                icon = "fa-solid fa-user-slash",
                onSelect = function()
                    TriggerEvent("police:client:manageservices", { status = true })
                end
            },
            {
                title = "Reactivate Services",
                description = "Reactivate a specific citizen's services",
                icon = "fa-solid fa-user-check",
                onSelect = function()
                    TriggerEvent("police:client:manageservices", { status = false })
                end
            },
            {
                title = "Exit",
                icon = "fa-solid fa-times",
                onSelect = function()
                    lib.hideMenu()
                end
            }
        }
    
        lib.registerContext({
            id = 'police_services_menu',
            title = 'Police Services',
            options = officerdetails
        })
    
        lib.showContext('police_services_menu')
    end
end)

RegisterNetEvent('police:client:manageservices', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    local action = data.status and "Deactivate" or "Reactivate"
    local service = exports['qb-input']:ShowInput({
        header = action .. " Citizen Services",
        submitText = action,
        inputs = {
            {
                text = "Citizen ID",
                name = "citizenid",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if service and service.citizenid then
        QBCore.Functions.TriggerCallback('police:server:servicescheck', function(result)
            if (data.status and result) or (not data.status and not result) then
                local msg = data.status and "already deactivated" or "already active"
                QBCore.Functions.Notify("Citizen ID [" .. service.citizenid .. "] is " .. msg .. "!", "error")
            else
                TriggerServerEvent("police:server:manageservices", service.citizenid, data.status)
                local statusMsg = data.status and "deactivated" or "reactivated"
                QBCore.Functions.Notify("Citizen ID [" .. service.citizenid .. "] has been " .. statusMsg .. "!", "success")
            end
        end, service.citizenid)
    end
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNetEvent('police:client:checkservices', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    local service = exports['qb-input']:ShowInput({
        header = "Check Citizen Services",
        submitText = "Search",
        inputs = {
            {
                text = "[CSN] Citizen ID",
                name = "citizenid",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if service and service.citizenid then
        QBCore.Functions.TriggerCallback('police:server:servicescheck', function(result)
            local statusMsg = result and "inactive" or "active"
            QBCore.Functions.Notify("Citizen ID [" .. service.citizenid .. "] services are " .. statusMsg .. "!", "info")
        end, service.citizenid)
    end
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

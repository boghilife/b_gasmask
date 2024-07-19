local maskIds = Config.gasmasks
local maskComponentId = Config.maskcomponent
local maskState = false

-- Notify framework check, more upcoming
if Config.notify == 'esx' then 
    ESX = exports["es_extended"]:getSharedObject()
end

/* FUNCTIONS */

-- Active/unactive subtitle
function DrawTextOnScreen(text)
    SetTextFont(2)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    -- SetTextDropShadow(0, 0, 0, 0, 255)
    -- SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(Config.textposition.x, Config.textposition.y)
end

-- Check for interior 
function CheckPlayerInterior(playerPed)
    if Config.disableInteriorUse then
        local playerInterior = GetInteriorFromEntity(playerPed)
        return playerInterior ~= 0
    end
    return false
end

-- Default standalone notification system
function Notify(Text, Flash)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Text)
	DrawNotification(Flash, true)
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local currentMaskId = GetPedDrawableVariation(playerPed, maskComponentId)
        local isPlayerDead = IsEntityDead(playerPed)
        local isSCBAActive = exports[Config.resourcename]:IsSCBA()
        local isEntityExist = DoesEntityExist(playerPed)
        local isPlayerInInterior = CheckPlayerInterior(playerPed)

        local isWearingSpecificMask = false
        for _, maskId in ipairs(maskIds) do
            if currentMaskId == maskId then
                isWearingSpecificMask = true
                break
            end
        end

        if isWearingSpecificMask and not isPlayerDead and not isPlayerInInterior then
            if not maskState then
                exports[Config.resourcename]:SetPlayerCough(false)
                maskState = true
                if Config.notify == 'esx' then
                    ESX.ShowNotification(Config.getLocale('gasmask_on_notify'), false)
                elseif Config.notify == 'default' then 
                    Notify('~g~'..Config.getLocale('gasmask_on_notify')..'', true)
                elseif Config.notify == 'false' then
                end
                if Config.debug then
                    print("GAS MASK: ON")
                end
            end
        else
            if maskState then
                exports[Config.resourcename]:SetPlayerCough(true)
                maskState = false
                if Config.notify == 'esx' then
                    ESX.ShowNotification(Config.getLocale('gasmask_off_notify'), false)
                elseif Config.notify == 'default' then 
                    Notify('~r~'..Config.getLocale('gasmask_off_notify')..'', true)
                elseif Config.notify == 'false' then
                end
                if Config.debug then
                    print("GAS MASK: OFF")
                end
            end
        end

        -- Prevent to use the SCBA (if it is linked) while using the mask
        if isSCBAActive and maskState then
            exports[Config.resourcename]:SetSCBA(false)
            if Config.notify == 'esx' then
                ESX.ShowNotification(Config.getLocale('scba_error_notify'), false)
            elseif Config.notify == 'default' then 
                Notify('~y~'..Config.getLocale('scba_error_notify')..'', true)
            elseif Config.notify == 'false' then
            end
            if Config.debug then
                print("SCBA LINKED WITH MASK ON, DISABLING THE SCBA")
            end
        end

        Citizen.Wait(1000)
    end
end)


-- local displayText = Config.getLocale('gasmask_active_text')
-- local displayTextInterior = Config.getLocale('gasmask_interior_text')
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         if maskState and Config.displaytext then
--             DrawTextOnScreen(displayText)
--         else
--             -- DrawTextOnScreen(displayTextInterior)
--         end
--     end
-- end)




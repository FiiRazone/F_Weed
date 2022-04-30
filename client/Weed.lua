ESX = nil

local Recolte = RageUI.CreateMenu("~r~Recolte", "~c~Point de recolte de la weed", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);
local Traitement = RageUI.CreateMenu("~r~Traitement", "~c~Point de traitement de la weed", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);
local Vente = RageUI.CreateMenu("~r~Vente", "~c~Point de vente de la weed", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);


----------------------------------------------------------------------------------------
--                                      RECOLTE                                       --
----------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	RegisterNetEvent('esx:playerLoaded') -- Store the players data
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        ESX.PlayerLoaded = true
    end)

    local distance, coords, pedCoords, interval
    while true do 
        interval = 0
        pedCoords = GetEntityCoords(PlayerPedId())
        coords = Config.Recolte.CoordsWeed
        distance = #(pedCoords - coords)

        if distance > 30 then
            interval = 5000
        else
            if distance < 2 then
                interval = 0
                AddTextEntry("help", "Appuyer sur ~r~E ~s~pour accéder à cette zone")
				DisplayHelpTextThisFrame("help", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(Recolte, not RageUI.Visible(Recolte))
                end
            else
                RageUI.CloseAll()
            end
        end
        Wait(interval)
    end
end)

isRecolte = false

function StopRecolte()
    if isRecolte then
        isRecolte = false
    end
end

function StartRecolte()
    if not isRecolte then
        isRecolte = true
        while isRecolte do
            Citizen.Wait(5000)
            TriggerServerEvent("startRecolteWeed")
        end
    else
        isRecolte = false
    end
end
----------------------------------------------------------------------------------------
--                                      TRAITEMENT                                    --
----------------------------------------------------------------------------------------
Citizen.CreateThread(function() 
    local distanceTraitement, coordsTraitement, pedcoordsTraitement, intervalTraitement
    while true do 
        intervalTraitement = 0
        pedcoordsTraitement = GetEntityCoords(PlayerPedId())
        coordsTraitement = Config.Traitement.CoordsWeed
        distanceTraitement = #(pedcoordsTraitement - coordsTraitement)

        if distanceTraitement > 30 then
            intervalTraitement = 5000
        else
            if distanceTraitement < 2 then
                intervalTraitement = 0
                AddTextEntry("help", "Appuyer sur ~r~E ~s~pour accéder à cette zone")
				DisplayHelpTextThisFrame("help", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(Traitement, not RageUI.Visible(Traitement))
                end
            else
                RageUI.CloseAll()
            end
        end
        Wait(intervalTraitement)
    end
end)

function StopTraitement()
    if traitementpossible then
        traitementpossible = false
    end
end

function StartTraitement()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
        Citizen.Wait(2000)
        TriggerServerEvent('startTraitementWeed')
    end
    else
        traitementpossible = false
    end
end

----------------------------------------------------------------------------------------
--                                      VENTE                                         --
----------------------------------------------------------------------------------------

Citizen.CreateThread(function() 
    local distanceVente, coordsVente, pedcoordsVente, intervalVente
    while true do 
        intervalVente = 0
        pedcoordsVente = GetEntityCoords(PlayerPedId())
        coordsVente = Config.Vente.CoordsWeed
        distanceVente = #(pedcoordsVente - coordsVente)

        if distanceVente > 30 then
            intervalVente = 5000
        else
            if distanceVente < 2 then
                intervalVente = 0
                AddTextEntry("help", "Appuyer sur ~r~E ~s~pour accéder à cette zone")
				DisplayHelpTextThisFrame("help", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(Vente, not RageUI.Visible(Vente))
                end
            else
                RageUI.CloseAll()
            end
        end
        Wait(intervalVente)
    end
end)

function stopVente()
    if ventepossible then
        ventepossible = false
    end
end

function startVente()
    if not ventepossible then
        ventepossible = true
    while ventepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('startVenteWeed')
    end
    else
        ventepossible = false
    end
end

----------------------------------------------------------------------------------------
--                                      RAGEUI V3                                     --
----------------------------------------------------------------------------------------

function RageUI.PoolMenus:Example()

	Recolte:IsVisible(function(Items)
        Items:AddButton("Commencer à recolter de la weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                Citizen.CreateThread(function()
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    StartRecolte()
                end)
            end
		end)
        Items:AddButton("Stoper la recolte de weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                StopRecolte()
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, false)
                ESX.ShowNotification("Vous avez arrêter de recolter de la weed")
            end
		end)
	end, function() end)

    Traitement:IsVisible(function(Items)
        Items:AddButton("Commencer à traiter de la weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                Citizen.CreateThread(function()
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    StartTraitement()
                end)
            end
		end)
        Items:AddButton("Stoper le traitement de la weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                StopTraitement()
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, false)
                ESX.ShowNotification("Vous avez arrêter de traiter de la weed")
            end
		end)
	end, function() end)

    Vente:IsVisible(function(Items)
        Items:AddButton("Commencer à vendre de la weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                Citizen.CreateThread(function()
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    startVente()
                end)
            end
		end)
        Items:AddButton("Stoper la vente de la weed", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)
            if onSelected then
                stopVente()
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, false)
                ESX.ShowNotification("Vous avez arrêter de traiter de la weed")
            end
		end)
	end, function() end)
end
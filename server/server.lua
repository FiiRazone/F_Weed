ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----------------------------------------------------------------------------------------
--                                      WEED                                          --
----------------------------------------------------------------------------------------

RegisterNetEvent("startRecolteWeed")
AddEventHandler("startRecolteWeed", function()
    local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur
    local nbininventaire = xPlayer.getWeight()
        if nbininventaire >= Config.InventaireMax then
            TriggerClientEvent('esx:showNotification', source, "Tu n'as pu de place")
        else
            xPlayer.addInventoryItem("Weed", 1)
        end
end)

RegisterNetEvent("startTraitementWeed")
AddEventHandler("startTraitementWeed", function()
    local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur
    local nbininventaireWeed = xPlayer.getInventoryItem("Weed").count
    local nbininventaire = xPlayer.getWeight()
    if nbininventaireWeed < Config.Traitement.WeedToPochon then
        TriggerClientEvent('esx:showNotification', source, "Tu n'as pu de Weed")
    else
        if nbininventaire > Config.InventaireMax then
            TriggerClientEvent('esx:showNotification', source, "Tu n'as pu de place")
        else
            xPlayer.removeInventoryItem("Weed", 3)
            xPlayer.addInventoryItem("Pochon_Weed", 1)
        end
    end
end)

RegisterNetEvent("startVenteWeed")
AddEventHandler("startVenteWeed", function()
    local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur
    local nbininventaire = xPlayer.getInventoryItem("Pochon_Weed").count
    local randomMoney = Config.Vente.PrixMeth
    if nbininventaire < 1 then
        TriggerClientEvent('esx:showNotification', source, "Tu n'as pu de pochon de Weed")
    else
        xPlayer.removeInventoryItem("Pochon_Weed", 1)
        xPlayer.addAccountMoney("black_money", randomMoney)
        TriggerClientEvent('esx:showNotification', source, "Tu as reçu "..randomMoney)
    end
end)
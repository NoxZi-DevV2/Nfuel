ESX = nil
open = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


function Nfuel()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'show',
        })
        open = true
        SendNUIMessage({
            action = "prix",
            prix = Config.Prix,
        })

        SendNUIMessage({
            action = "reservoir",
            reservoir = Config.Reservoir,
        })
    
        SendNUIMessage({
            action = "litreactuel",
            litreactuel = Round(GetVehicleFuelLevel(GetPlayersLastVehicle()), 1)
        })
    
        SendNUIMessage({
            action = "vehicle",
            vehicle = GetLabelText((GetDisplayNameFromVehicleModel(ESX.Game.GetVehicleProperties(GetPlayersLastVehicle()).model))),
        })
    
        SendNUIMessage({
            action = "currentfuel",
            currentfuel = Round(GetVehicleFuelLevel(GetPlayersLastVehicle()), 1)
        })
    

end

function CloseNfuel()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'hide',
    })
    open = false
end

RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)
    CloseNfuel()
    open = false 
end)


Citizen.CreateThread(function()
    while true do
        local interval = 500
        for k, v in pairs(Config.Station) do
            local ped = PlayerPedId()
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), v.Position.x, v.Position.y, v.Position.z, true)

            if distance <= 3.5 then
                DrawMarker(1, v.Position.x, v.Position.y, v.Position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 100, 0, 0, 255)
                interval = 0
            end
            if distance <= 3.5 then
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour acceder a la Station Essence")
                if IsControlJustPressed(1, 51) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        Nfuel()
                    else
                        ESX.ShowNotification("~b~Stations Essence~s~\nErreur : ~r~Vous devait etre dans un vehicule !")
                    end 
                end 
            end 
        end
       Wait(interval)
    end 
end)

RegisterNuiCallback('Plein50', function(data, cb)
    CloseNfuel()
    local joueur = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(joueur)
    local essence = 50.0
    local price = 125
    SetVehicleFuelLevel(vehicle, essence)
    ESX.ShowNotification("~b~Stations Essence~s~\nRéservoir : ~r~"..essence.."%~s~\nPrix : ~g~"..price.." $")
    Main = true
    demi = false
    
end)

RegisterNuiCallback('Plein100', function(data, cb)
    CloseNfuel()
    local player = PlayerPedId()
    local vehicule = GetVehiclePedIsIn(player)
    local essence = 100.0
    local price = 100*Config.Prix
    SetVehicleFuelLevel(vehicule, essence)
    ESX.ShowNotification("~b~Stations Essence~s~\nRéservoir : ~r~"..essence.."%~s~\nPrix : ~g~"..price.." $")
    Main = true
    demi = false
end)

RegisterNUICallback('plein', function(data)               -----------donner liquides
    CloseNfuel()
    local fuel = Round(GetVehicleFuelLevel(GetPlayersLastVehicle()), 1)
    local player = PlayerPedId()
    local vehicule = GetVehiclePedIsIn(player)
    local price = data.amountw*Config.Prix
    local montant = data.amountw..".0"
    local total = fuel+tonumber(montant)

    if tonumber(total) <= Config.Reservoir then
        SetVehicleFuelLevel(vehicule, total)
    else
        ESX.ShowNotification("~b~Stations Essence~s~\nErreur : ~r~Votre reservoir na pas la capaciter %~s~\nCapaciter Max : ~g~"..Config.Reservoir.." L")
        return
    end 
    ESX.ShowNotification("~b~Stations Essence~s~\nRéservoir : ~r~"..data.amountw.."%~s~\nPrix : ~g~"..price.." $")
    Main = true
    demi = false
end)

Citizen.CreateThread(function()
    if  true then		
      for k,v in pairs(Config.Station) do

          local blip = AddBlipForCoord(v.Position.x, v.Position.y, v.Position.z)

          SetBlipSprite (blip, 361)
          SetBlipDisplay(blip, 4)
          SetBlipScale  (blip, 0.7)
          SetBlipColour (blip, 1)
          SetBlipAsShortRange(blip, true)
          
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString("Station Essence")
          EndTextCommandSetBlipName(blip)
        end
      end
end)







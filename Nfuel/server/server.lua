ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("openmenupersonel:getData")
AddEventHandler("openmenupersonel:getData", function()
    if true then
        local Player = ESX.GetPlayerFromId(source)
        TriggerClientEvent('openmenupersonel:setData', source, GetDisplayNameFromVehicleModel(ESX.GetVehicleProperties(GetPlayersLastVehicle()).model), Player.getAccount("bank").money, Player.getAccount("black_money").money, Player.getJob().grade_label,  Player.getJob().label, Player.getName())

end
end)

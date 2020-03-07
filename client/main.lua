ESX                           = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))

    for k, v in pairs(Config.Locations) do
      if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
        DrawMarker(6, v.x, v.y, v.z-0.95, 0, 0, 0.1, 0, 0, 0, 1.2, 1.2, 1.2, 0, 205, 100, 200, 0, 0, 0, 0)
        Draw3DText(v.x, v.y, v.z+0.17, 'Tryck ~g~E~w~ för att öppna ~b~Menyn')
				if IsControlPressed(0, 38) then
          OpenMenu()
				end
			end
		end
	end
end)

RegisterNetEvent('explicit_dykning:kit')
AddEventHandler('explicit_dykning:kit', function(source)
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      playAnim('missheistdockssetup1hardhat@', 'put_on_hat', 2500)
      Citizen.Wait(500)
      TriggerEvent('skinchanger:loadClothes', skin, Config.ItemWear.male)
      SetPedMaxTimeUnderwater(GetPlayerPed(-1), 500.00)
    else
      playAnim('missheistdockssetup1hardhat@', 'put_on_hat', 2500)
      Citizen.Wait(500)
      TriggerEvent('skinchanger:loadClothes', skin, Config.ItemWear.female)
      SetPedMaxTimeUnderwater(GetPlayerPed(-1), 470.00)
    end
  end)
end)

Citizen.CreateThread(function()
	if Config.EnableBlips then
		for k, v in pairs(Config.Locations) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, 382)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 38)
			SetBlipDisplay(blip, 4)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Dykningsplats")
			EndTextCommandSetBlipName(blip)
		end
	end
end)
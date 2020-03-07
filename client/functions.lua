OpenMenu = function()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'dykning',
    {
      title    = 'Välj Alternativ',
      align    = 'center',
      elements = {
    {label = 'Byt om till dykar kläder', value = 'dykning'},
    {label = 'Byt om till civil kläder', value = 'civil'},
      },
    },
    function(data, menu)
    
      if data.current.value == 'civil' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          playAnim('oddjobs@basejump@ig_15', 'puton_parachute', 2500)
          Citizen.Wait(3000)
          TriggerEvent('skinchanger:loadSkin', skin)
          menu.close()
          SetEnableScuba(GetPlayerPed(-1),false)
          SetPedMaxTimeUnderwater(GetPlayerPed(-1), 16.00)
          sendNotification('Du bytte om hoppas din dyktur var rolig och du är välkommen tilbaka när du vill', 'error', 4000)
        end)
      end
      
      if data.current.value == 'dykning' then
          TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
              playAnim('oddjobs@basejump@ig_15', 'puton_parachute', 2500)
              Citizen.Wait(3000)
              TriggerEvent('skinchanger:loadClothes', skin, Config.DykWear.male)
              menu.close()
              SetEnableScuba(GetPlayerPed(-1),true)
              SetPedMaxTimeUnderwater(GetPlayerPed(-1), 2000.00)
              sendNotification('Du bytte om ha en trevlig dyktur men var försiktig och kom ihåg att alla skador sker på egen risk', 'error', 4000)
            else
              playAnim('oddjobs@basejump@ig_15', 'puton_parachute', 2500)
              Citizen.Wait(3000)
              TriggerEvent('skinchanger:loadClothes', skin, Config.DykWear.female)
              menu.close()
              SetEnableScuba(GetPlayerPed(-1),true)
              SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1950.00)
              sendNotification('Du bytte om ha en trevlig dyktur men var försiktig och kom ihåg att alla skador sker på egen risk', 'error', 4000)
            end
          end)
        end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

Draw3DText = function(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*1
  local fov = (1/GetGameplayCamFov())*100
  local scale = 1.9
  local factor = (string.len(text)) / 350
 
  if onScreen then
    SetTextScale(0.0*scale, 0.18*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    DrawRect(_x,_y+0.0115, 0.01+ factor, 0.025, 25, 25, 25, 185)
  
  end
end

playAnim = function(animDict, animName, duration)
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, duration, 0, 0, false, false, false)
	  RemoveAnimDict(animDict)
end

sendNotification = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "kok",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

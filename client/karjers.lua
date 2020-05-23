workClothes = false
local gerbtuveLoc = vector3(2707.2954101563,2777.0639648438,37.878036499023)
local rentLoc = vector3(2763.9206542969,2807.3076171875,40.364475250244)
local spawnPos = vector3(2772.5412597656,2806.8098144531,41.218772888184)
local spawnPosW = 300.46841430664

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

CreateThread(function()
	while true do

		Wait(0)

		
		Draw3DText(gerbtuveLoc.x, gerbtuveLoc.y, gerbtuveLoc.z+0.5, "Pargerbties", 0, 191, 255, 255)
		DrawMarker(31, gerbtuveLoc.x, gerbtuveLoc.y, gerbtuveLoc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, nil, nil, false)

		local player = GetPlayerPed(-1)
		local playerLoc = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, gerbtuveLoc.x, gerbtuveLoc.y, gerbtuveLoc.z, true)

		if dist <= 2 then
			DisplayHelpText("Nospiediet ~INPUT_CONTEXT~ ,lai pargerbtos")
			if IsControlJustPressed(1,51) and workClothes == false then -- "E"
				TriggerServerEvent('StartWork', PlayerId())

			elseif IsControlJustPressed(1,51) and workClothes == true then
				TriggerServerEvent('EndWork', rudaKG, totalRuda)
			end
        end

		Draw3DText(rentLoc.x, rentLoc.y, rentLoc.z+1, "Panemt darba auto", 0, 191, 255, 255)
		DrawMarker(1, rentLoc.x, rentLoc.y, rentLoc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, nil, nil, false)

		local dist = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, rentLoc.x, rentLoc.y, rentLoc.z, true)

		if dist <= 2 then
			DisplayHelpText("Nospiediet ~INPUT_CONTEXT~ ,lai sanemtu darba auto")
			if IsControlJustPressed(1,51) then -- "E"
				if(workClothes == false) then
					TriggerEvent('ShowWarning', "~r~Vispirms saciet stradat!")
				else
					TriggerEvent('SpawnAuto')
				end
			end
        end

		local vehicle = GetVehiclePedIsTryingToEnter(player)
		if(vehicle ~= nil) then
			local model = GetEntityModel(vehicle)

			if(model == GetHashKey('BULLDOZER') and workClothes == false) then
				TriggerEvent('ShowWarning', "~r~Vispirms saciet stradat!")
				SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
			elseif model == GetHashKey('BULLDOZER') and workClothes == true then
				SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
			end

		end
		
	end
end)


-- We declare this 'msg' function on the bottom due to better practices.
function msg(text)
    -- TriggerEvent will send a chat message to the client in the prefix as red
    TriggerEvent("chatMessage",  "[Server]", {255,0,0}, text)
end

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
	AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('Pargerbties')
AddEventHandler('Pargerbties', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if(workClothes == false) then
			if(skin.sex == 0) then
				local clothesSkin = {
					['tshirt_1'] 	= 15, ['tshirt_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
					['torso_1'] 	= 162, ['torso_2'] = 0,
					['decals_1'] 	= 0,  ['decals_2'] = 0,
					['mask_1'] 		= 0, ['mask_2'] = 0,
					['arms'] 		= 15,
					['pants_1'] 	= 6, ['pants_2'] = 1,
					['shoes_1'] 	= 12, ['shoes_2'] = 0,
					['helmet_1'] 	= 0, ['helmet_2'] = 0,
					['bags_1']		= 0, ['bags_2'] = 0,
					['glasses_1'] = 23, ['glasses_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
					['bproof_1'] 	= 0,  ['bproof_2'] 	= 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			else
				local clothesSkin = {
					['tshirt_1'] 	= 15, ['tshirt_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
					['torso_1'] 	= 158, ['torso_2'] = 0,
					['decals_1'] 	= 0,  ['decals_2'] = 0,
					['mask_1'] 		= 0, ['mask_2'] = 0,
					['arms'] 		= 15,
					['pants_1'] 	= 2, ['pants_2'] = 2,
					['shoes_1'] 	= 2, ['shoes_2'] = 0,
					['helmet_1'] 	= 0, ['helmet_2'] = 0,
					['bags_1']		= 0, ['bags_2'] = 0,
					['glasses_1'] = 25, ['glasses_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
					['bproof_1'] 	= 0,  ['bproof_2'] 	= 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end

			TriggerEvent('ShowWarning', "Jus sakat stradat")
			workClothes = true
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
				TriggerEvent('ShowWarning', "Jus beidzat stradat")
			end)
			workClothes = false
		end
	end)
end)

RegisterNetEvent('SpawnAuto')
AddEventHandler('SpawnAuto', function()
		local vehicleName = 'bulldozer'
		RequestModel(vehicleName)
		while not HasModelLoaded(vehicleName) do
			Wait(500)
		end
		if ( DoesEntityExist( vehicle ) ) then
			SetEntityAsMissionEntity( vehicle, true, true )
			DeleteVehicle( vehicle)
		end
		vehicle = CreateVehicle(vehicleName, spawnPos.x,spawnPos.y,spawnPos.z,spawnPosW, true, false)
		
		SetEntityAsNoLongerNeeded(vehicle)

		-- release the model
		SetModelAsNoLongerNeeded(vehicleName)
end)

function Draw3DText(x, y, z, text, r, g, b, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	if(distance < 30) then
		local scale = (1 / distance) * 2
		local fov = (1 / GetGameplayCamFov()) * 100
		local scale = scale * fov
		if onScreen then
			SetTextScale(0.0, 0.35)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextColour(r, g, b, a)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			DrawText(_x,_y)
		end
	end
end
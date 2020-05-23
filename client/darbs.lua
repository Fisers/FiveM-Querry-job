ruudaPos = {
	vector3(2971.4270019531,2792.76171875,39.442253112793), 
	vector3(2970.3254394531,2780.2824707031,37.790603637695), 
	vector3(2952.5119628906,2774.4086914063,38.264873504639), 
	vector3(2936.6921386719,2780.0144042969,38.273765563965), 
	vector3(2930.6320800781,2794.1801757813,39.60856628418), 
	vector3(2933.4382324219,2809.8112792969,41.807800292969), 
	vector3(2947.8779296875,2794.1174316406,39.673583984375), 
	vector3(2954.6779785156,2784.4018554688,40.156135559082), 
	vector3(2976.0920410156,2750.4672851563,42.049137115479), 
	vector3(2993.212890625,2758.3879394531,41.749870300293), 
	vector3(2936.6555175781,2797.3190917969,39.842575073242)
}
endPos = vector3(2681.7954101563,2799.9736328125,39.118328094482)
rudaKG = 0
totalRuda = 0

propOffset = vector3(0.0, 3.8, 0.45)

CreateThread(function()
	while true do

		Wait(0)

		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
		if(vehicle ~= nil) then
			local model = GetEntityModel(vehicle)

			if(model == GetHashKey('BULLDOZER') and workClothes == true) then
				if(currentRuudaPos == nil and rudaKG == 0) then
					local pos = math.random(0, 10)
					currentRuudaPos = ruudaPos[pos]

					SetNewWaypoint(currentRuudaPos.x, currentRuudaPos.y)

					TriggerEvent('ShowWarning', "Brauc pec rudas")
				elseif (currentRuudaPos ~= nil) then
					if(not IsWaypointActive()) then
						SetNewWaypoint(currentRuudaPos.x, currentRuudaPos.y)
					end
					DrawMarker(1, currentRuudaPos.x, currentRuudaPos.y, currentRuudaPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)

					local playerLoc = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, currentRuudaPos.x, currentRuudaPos.y, currentRuudaPos.z, true)

					if dist <= 5 then
						TriggerEvent('ShowWarning', "Vediet rudu uz nodosanas punktu!")
						currentRuudaPos = nil

						SetNewWaypoint(endPos.x, endPos.y)
						rudaKG = math.random(300, 500)
						--[[local prop = CreateObject('prop_air_bigradar_l1', 0.0, 0.0, 0.0, true, true, true)

						AttachEntityToEntity('prop_air_bigradar_l1', vehicle, GetEntityBoneIndexByName(vehicle, "chassis"), propOffset, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)]]--
					end
				end

				

				if(rudaKG > 0) then
					DrawMarker(1, endPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)

					local playerLoc = GetEntityCoords(GetPlayerPed(-1), false)
					local dist = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, endPos, true)

					if dist <= 5 then
						TriggerEvent('ShowWarning', "Jus nodevat " .. rudaKG .. "kg rudas!")
						totalRuda = totalRuda + rudaKG
						rudaKG = 0
						TriggerEvent('ShowWarning', "Kopa nodoti " .. totalRuda .. "kg rudas!")
					end
				end
			end

		end
	end
end)
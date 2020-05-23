local mReady = false

AddEventHandler('onMySQLReady', function ()
	mReady = true
end)

RegisterServerEvent('StartWork')
AddEventHandler('StartWork', function(player)
	local users = MySQL.Sync.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = GetPlayerIdentifier(source)})
    if (users[1].DmvTest == "Required") then
        TriggerClientEvent('ShowWarning', source, "~r~Jums nav autovaditaja tiesibas!")
	else
		TriggerClientEvent('Pargerbties',source)
    end
end)

RegisterServerEvent('EndWork')
AddEventHandler('EndWork', function(ruda, total)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		user.addMoney(1.1*total)
		TriggerClientEvent('ShowWarning', source, "Jus nopelnijat " .. 1.1*total .. "$")

		TriggerClientEvent('Pargerbties',source)
	end)
end)
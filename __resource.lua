resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

--resource_type 'gametype' { name = 'newmode roleplay' }

client_script 'client/karjers.lua'
client_script 'client/darbs.lua'

server_script 'server/karjers.lua'
server_script '@mysql-async/lib/MySQL.lua'

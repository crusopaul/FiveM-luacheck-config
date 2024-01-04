
RegisterNetEvent('example:server:foo', function()
    local src = source
    
    TriggerClientEvent('example:client:bar', src, 'hi!')
end)

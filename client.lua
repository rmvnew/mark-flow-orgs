local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","flow_orgs")
src = {}
Tunnel.bindInterface("flow_orgs",src)
vSERVER = Tunnel.getInterface("flow_orgs")
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local is_openned = false

src.openNui = function(org)
    if vSERVER.checkAuth() then
        if not is_openned then
            local infos,members,ranking = vSERVER.getInfosOrg(org)
            if infos and members then
                SetNuiFocus(true,true)
                SetCursorLocation(0.5,0.5)
                SendNUIMessage({ show = true, infos = infos, members = members, ranking = ranking })
                is_openned = true
            end
        end
    end
end

src.updateNui = function(org)
    if vSERVER.checkAuth() then
        local infos,members,ranking = vSERVER.getInfosOrg(org)
        if infos and members then
            SetNuiFocus(true,true)
            SetCursorLocation(0.5,0.5)
            SendNUIMessage({ show = true, update = true, infos = infos, members = members, ranking = ranking })
        end
    end
end

src.closeNui = function()
    if vSERVER.checkAuth() then
        SetNuiFocus(false,false)
        SendNUIMessage({ show = false })
        is_openned = false
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('closeNUI', function()
    src.closeNui()
end)

RegisterNUICallback('invite', function(data)
    if data.user_id > 0 then
        vSERVER.invitePlayer(data.user_id, data.orgName, data.cargo)
    end
end)

RegisterNUICallback('promove', function(data)
    if parseInt(data.user_id) > 0 then
        vSERVER.promovePlayer(data.user_id, data.orgName, data.cargo)
    end
end)

RegisterNUICallback('demitir', function(data)
    if data.user_id > 0 then
        vSERVER._demitirPlayer(data.user_id, data.orgName)
    end
end)

RegisterNUICallback('anotar', function(data)
    vSERVER._anotar(data.orgName, data.anotacao)
end)

RegisterNUICallback('pedircontas', function(data)
    vSERVER._pedirContas(data.orgName)
end)

RegisterNUICallback('sacar', function(data)
    vSERVER._sacar(data.orgName, data.value)
end)

RegisterNUICallback('depositar', function(data)
    vSERVER._depositar(data.orgName, data.value)
end)

-- #####################################

RegisterNUICallback('configurarMeta', function(data)
    
    if data then
        vSERVER.configurarMeta(data.orgName, data.produtos, data.pagamento)
    end    
    
end)

function src.openConfigMeta(orgName)
    
    SetNuiFocus(true,true)
    SendNuiMessage({showConfigMeta = true, orgName= orgName})
    
end    

-- #####################################

RegisterNUICallback('getMetaConfig',function(data,cb)

    local metaData = vSERVER.getMetaConfig(data.orgName)

    cb(metaData)

end)


RegisterNUICallback('checkPermission',function(_,cb)

    local result = vSERVER.checkPermission()
    cb(result)

end)


RegisterNUICallback('getMetaDetails', function(data, cb)
    local orgName = data.orgName

    print('DEBUG: No Client chegou com nome:', orgName)

    if not orgName or orgName == "" then
        print('ERRO: orgName é nulo ou inválido.')
        cb({ success = false, error = 'Organização inválida.' })
        return
    end

    -- Busca os detalhes da meta no servidor
    local metaDetails = vSERVER.getMetaDetails(orgName)
    cb(metaDetails)
end)


RegisterNUICallback('payMeta', function(data, cb)
    local orgName = data.orgName
    local payment = data.payment

    local success, error = vSERVER.payMeta(orgName,payment)
    cb({ success = success, error = error })
end)


RegisterNetEvent("flow_orgs:closeMetaModal")
AddEventHandler("flow_orgs:closeMetaModal",function()

    SendNUIMessage({action = "closeMetaModal"})

end)
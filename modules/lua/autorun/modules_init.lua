MODULES = {}
MODULES.tbl = {}

--[[-------------------------------------------------------------------------
Adds a module to load
---------------------------------------------------------------------------]]
function MODULES.AddModule(name, author, moduleFolder)
    local Module = {}
    Module.name = name
    Module.author = author
    Module.folder = moduleFolder

    if (SERVER) then
        AddCSLuaFile("modules/" .. moduleFolder .. "/cl_init.lua")
        include("modules/" .. moduleFolder .. "/init.lua")
    else
        include("modules/" .. moduleFolder .. "/cl_init.lua")
    end

    table.insert(MODULES.tbl, Module)
end

--[[-------------------------------------------------------------------------
Checks the module
---------------------------------------------------------------------------]]
function MODULES.GetModule(name)
    for k, v in pairs(MODULES.tbl) do
        if v.name == name then return v end
    end
end

if (CLIENT) then
    function MODULES.ReloadAllClient()
        for k, v in pairs(MODULES.tbl) do
            include("modules/" .. v.folder .. "/cl_init.lua")
        end
    end

    net.Receive("modules_reload_all_client", MODULES.ReloadAllClient)
end

if (SERVER) then
    util.AddNetworkString("modules_reload_all_client")

    function MODULES.ConCommandReloadAdmin(pl)
        if (pl:IsSuperAdmin() == false) then
            pl:Kick("No Access")

            return false
        end

        MODULES.ReloadAllServer()
        net.Start("modules_reload_all_client")
        net.Broadcast()
    end

    concommand.Add("modules_reloadAll", MODULES.ConCommandReloadAdmin)

    function MODULES.ReloadAllServer()
        for k, v in pairs(MODULES.tbl) do
            AddCSLuaFile("modules/" .. v.folder .. "/cl_init.lua")
            include("modules/" .. v.folder .. "/init.lua")
        end
    end
end



--[[-------------------------------------------------------------------------
Exemples
---------------------------------------------------------------------------]]
--MODULES.AddModule("Module Name", "author", "folder name")
MODULES.AddModule("API System", "Rahkye", "apimodule")
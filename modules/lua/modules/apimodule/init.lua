print("[sv] API worked!")

API = {}
API.player = FindMetaTable("Player")
API.Entity = FindMetaTable("Entity")

--[[-------------------------------------------------------------------------

The function returns the player among the list of players
Function accepts both nickname and steam id
If nothing found returns nil

---------------------------------------------------------------------------]]

-- local findPlayer = API.GetPlayer("Rahkye")
-- local findPlayer = API.GetPlayer("STEAM_0:0")

function API.GetPlayer(any_ind)
    local mode = "nickname"

    if (string.find(any_ind, "STEAM_")) then
        mode = "steamid"
    end

    for k, v in pairs(player.GetAll()) do
        if (mode == "nickname") then
            if v:Nick() == any_ind then return v end
        else
            if v:SteamID() == any_ind then return v end
        end
    end

    return nil
end

--[[-------------------------------------------------------------------------
The function returns the entity that the player is looking at if there is no entity in front of it returns nil
---------------------------------------------------------------------------]]

-- local lookEntity = ply:getEntityLookPlayer()
function API.player:getEntityLookPlayer()
    return self:GetEyeTraceNoCursor().Entity or nil
end

--[[-------------------------------------------------------------------------
The function returns the player that the player is looking at if there is one if not then nil
---------------------------------------------------------------------------]]

-- local lookPlayer = ply:getPlayerLook()
function API.player:getPlayerLook()
    local pl = self:getEntityLookPlayer()
    if pl == nil then return nil end
    if pl:IsPlayer() == false then return nil end

    return pl
end

--[[-------------------------------------------------------------------------
Lib - todo
---------------------------------------------------------------------------]]
function API.CreateData(ind)
end

function API.RemoveData(ind)
end

function API.WriteData(ind, ceil, value)
end

function API.GetData(ind, ceil)
end

function API.RemoveCeil(ind, ceil)
end

--[[-------------------------------------------------------------------------
Nothing
---------------------------------------------------------------------------]]
function API.writeNetData()
end

function API.readNetData()
end

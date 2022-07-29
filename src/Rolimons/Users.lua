local Http = require(script.Parent.Modules.Http)
local Format = require(script.Parent.Modules.Format)

local Users = { }
Users.__index = Users


function Users.GetUserData(UserId, IncludeItemData)
    if not(UserId)then return error("Argument #1 of Users.GetUserData is missing or nil.") end

    local Success, Connection = Http.Get("api/playerassets/"..tostring(UserId))
    local connectionSuccess, Body = Connection.Success, Http.Decode(Connection.Body)

    if(Success and connectionSuccess)then
        return Format.UserData(Body, IncludeItemData)
    end
end

return Users
local Http = require(script.Parent.Modules.Http)
local Cache = require(script.Parent.Modules.Cache)
local Format = require(script.Parent.Modules.Format)

local Items = { }
Items.__index = Items

function Items.GetItemDetails(Id)
    if not(Id)then return error("Argument #1 of Items.GetItemDetials is missing or nil.") end
    repeat
        task.wait()
    until Cache.ITEM_DETIALS

    if(Cache.ITEM_DETIALS.Items[tonumber(Id)])then
        return Cache.ITEM_DETIALS.Items[tonumber(Id)]
    end
end

coroutine.wrap(function()
    while true do
        local Success, Connection = Http.Get("itemapi/itemdetails")
        local connectionSuccess, Body = Connection.Success, Http.Decode(Connection.Body)

        if(Success and connectionSuccess)then
            Cache.ITEM_DETIALS = Format.ItemDetails(Body)
        else
            warn("Failed to fetch itemapi/itemdetials")
        end
        task.wait(300)
    end
end)()

return Items

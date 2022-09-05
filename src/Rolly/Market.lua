local Http = require(script.Parent.Modules.Http)
local Format = require(script.Parent.Modules.Format)

local Market = { }
Market.__index = Market

function Market.GetMarketActivity()
    local Success, Connection = Http.Get("api/activity")
    local connectionSuccess, Body = Connection.Success, Http.Decode(Connection.Body)

    if(Success and connectionSuccess)then
        return Format.MarketActivity(Body)
    end
end

return Market
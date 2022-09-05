local Http = require(script.Parent.Modules.Http)
local Format = require(script.Parent.Modules.Format)

local TradeAds = { }
TradeAds.__index = TradeAds

function TradeAds.GetRecentAds(IncludeItemDetails)
    local Success, Connection = Http.Get("tradeadsapi/getrecentads")
    local connectionSuccess, Body = Connection.Success, Http.Decode(Connection.Body)
    
    if(Success and connectionSuccess)then
        return Format.TradeAd(Body, IncludeItemDetails)
    end
end

return TradeAds
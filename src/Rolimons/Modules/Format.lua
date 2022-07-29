local Cache = require(script.Parent.Cache)

local Format = {
    DEMAND_TOOL = {
        [-1]  = "None",
        [0]  = "Terrible",
        [1]  = "Low",
        [2]  = "Normal",
        [3]  = "High",
        [4]  = "Amazing",
    },
    TREND_TOOL = {
        [-1] = "None",
        [0] = "Lowering",
        [1] = "Unstable",
        [2] = "Stable",
        [3] = "Raising",
        [4] = "Fluctuating",
    },
    BOOL_TOOL = {
        [-1] = false,
        [1] = true,
    },
    TAG_TOOL = {
        [1] = "Demand",
        [2] = "Rares",
        [3] = "Robux",
        [4] = "Any",
        [5] = "Upgrade",
        [6] = "Downgrade",
        [7] = "Rap",
        [8] = "Wishlist",
        [9] = "Projecteds",
        [10] = "Adds",
    },
    SHALLOW_COPY = function(Original)
        local Clone = { }
        
        for Key, Value in pairs(Original)do
            Clone[Key] = Value
        end

        return Clone
    end
 }
Format.__index = Format

function Format.ItemDetails(Table)
    local newData = {
        ItemCount = Table["item_count"],
        Items = { }
    }

    for Key, Value in pairs(Table["items"])do
        local itemData = { }

        itemData.Name = Value[1]

        if(Value[2] == "")then 
            itemData.Acronym = "None"
        else
            itemData.Acronym = Value[2]
        end 

        itemData.Rap = Value[3]

        if(Value[4] == -1)then 
            itemData.Value = 0
        else
            itemData.Value = Value[4]
        end 

        itemData.DefaultValue = Value[5]
        itemData.Demand = Format.DEMAND_TOOL[Value[6]]
        itemData.Trend = Format.TREND_TOOL[Value[7]]
        itemData.Projected = Format.BOOL_TOOL[Value[8]]
        itemData.Hyped = Format.BOOL_TOOL[Value[9]]
        itemData.Rare = Format.BOOL_TOOL[Value[10]]

        newData.Items[tonumber(Key)] = itemData
    end

    return newData
end

function Format.UserData(Table, IncludeItemData)
    local newData = {
        Badges = { },
        ChartNominalScanTime = Table["chartNominalScanTime"],
        IsOnline = Table["isOnline"],
        LastLocation = Table["lastLocation"],
        LastOnline = Table["lastOnline"],
        LocationGameIsTracked = Table["locationGameIsTracked"],
        Assets = {},
        UserId = Table["playerId"],
        PlayerPrivacyEnabled = Table["playerPrivacyEnabled"],
        Terminated = Table["playerTerminated"],
        Verified = Table["playerVerified"], 
        HasPremium = Table["premium"], 
    }

    for Key, Value in pairs(Table["badges"])do
        newData.Badges[Key] = Value
    end

    if(IncludeItemData)then
        repeat
            task.wait()
        until Cache.ITEM_DETIALS

        for Key, Value in pairs(Table["playerAssets"])do
            if(Cache.ITEM_DETIALS.Items[tonumber(Key)])then
                local clonedItemData = Format.SHALLOW_COPY(Cache.ITEM_DETIALS.Items[tonumber(Key)])
                clonedItemData["UAID"] = Value[1]
                newData.Assets[Key] = clonedItemData
            else
                newData.Assets[Key] = Value[1]
            end
        end
    else
        for Key, Value in pairs(Table["playerAssets"])do
            newData.Assets[Key] = Value[1]
        end
    end

    return newData
end

function Format.TradeAd(Table, IncludeItemData)
    local newData = {
        TradeAdCount = Table["trade_ad_count"],
        TradeAds = { }
    } 

    for Key, Value in pairs(Table["trade_ads"])do
        local tradeData = { 
            UserId = Value[3],
            UserName = Value[4],
            Offering = { },
            Requesting = {
                Items = { },
                Tags = { }
            }
        }

        for Key, Value in pairs(Value[5]["items"])do
            if(IncludeItemData)then
                repeat
                    task.wait()
                until Cache.ITEM_DETIALS

                if(Cache.ITEM_DETIALS.Items[tonumber(Value)])then
                    local clonedItemData = Format.SHALLOW_COPY(Cache.ITEM_DETIALS.Items[tonumber(Value)])
                    tradeData.Offering[Value] = clonedItemData
                else
                    tradeData.Offering[Key] = Value
                end
            else
                tradeData.Offering[Key] = Value
            end
        end

        if(Value[6]["items"])then
            for Key, Value in pairs(Value[6]["items"])do
                if(IncludeItemData)then
                    repeat
                        task.wait()
                    until Cache.ITEM_DETIALS

                    if(Cache.ITEM_DETIALS.Items[tonumber(Value)])then
                        local clonedItemData = Format.SHALLOW_COPY(Cache.ITEM_DETIALS.Items[tonumber(Value)])
                        tradeData.Requesting.Items[Value] = clonedItemData
                    else
                        tradeData.Requesting.Items[Key] = Value
                    end
                else
                    tradeData.Requesting.Items[Key] = Value
                end
            end
        end


        if(Value[6]["tags"])then
            for Key, Value in pairs(Value[6]["tags"])do
                table.insert(tradeData.Requesting.Tags, Format.TAG_TOOL[Value])
            end
        end

        table.insert(newData.TradeAds, tradeData)
    end

    return newData
end

return Format
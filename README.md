# Rolly

> **What is it?**
* This module is made to interact with the [Roliomons](https://www.rolimons.com/) API. Easy to use, It's lightweight meaning it will not take much memory in your game so your game will still run very smoothly.

> **What Does it Include?**

* It uses [roblox-promises](https://eryn.io/roblox-lua-promise/) to make sure that everything is handled smoothly especially the `GET` request to the API.

* It also uses a Cache system to store necessary data, so the module doesn't have to spam request the API, however, the Cache does refresh every 300 seconds or 5 minutes.

* Currently it only supports the following endpoints
  * https://www.rolimons.com/tradeadsapi/getrecentads
  * https://www.rolimons.com/api/playerassets/
  * https://www.rolimons.com/itemapi/itemdetails
  * https://www.rolimons.com/api/activity

> **How do I get it?**
* Simply get the model from Roblox.
https://www.roblox.com/library/10393564814/Roli-Module

> **How do I use it?**
```lua
local Rolly = require(game.ReplicatedStorage.Rolly)
local Items = Rolly.Items
local Users = Rolly.Users
local TradeAds = Rolly.TradeAds
local Market = Rolly.Market

print(Items.GetItemDetails(1029025)) --> Classic Fedora
print(Users.GetUserData(135190312)) --> Fetch UserData
print(Users.GetUserData(135190312, true)) --> Fetch UserData w/ Item Details.
print(TradeAds.GetRecentAds()) --> Fetch RecentAds
print(TradeAds.GetRecentAds(true)) --> Fetch RecentAds w/ Item Details.
print(Market.GetMarketActivity()) --> Fetches Market Activity
```

> **How do I use it?**
* Here is an example game I made using the module, https://www.roblox.com/games/10379476837/Rolly

> **Suggestions**
* If you have any ideas/suggestions for the module make sure to comment them!
* This module is not yet finished and I'd like to add more to it in the future!

> **GitHub**
* The module is fully open-sourced and free to use, If would like to contribute the project  feel free to using the the [Github Repository](https://github.com/workframes/Rolimons).

> **Contact**
* You can contact me through Discord, frames#4888

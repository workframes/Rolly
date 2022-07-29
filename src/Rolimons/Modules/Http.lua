local HttpService = game:GetService("HttpService")
local Promise = require(script.Parent.Promise)

local Http = {
    BASE_URL = "https://www.rolimons.com/%s"
}
Http.__index = Http

function Http.Request(Url, Method, Headers, Body)
    if not(Url)then 
        return error("Argument #1 of Http.Request is missing or nil.") 
    elseif (type(Url) ~= "string")then
        return error("Argument #1 of Http.Request must be a string.") 
    end

    if not(Method)then 
        return error("Argument #2 of Http.Request is missing or nil.")
    elseif (type(Url) ~= "string")then
        return error("Argument #2 of Http.Request must be a string.") 
    end

    if(Headers and type(Headers) ~= "table")then return error("Argument #3 of Http.Request must be a table.") end 
    if(Body and type(Body) ~= "string")then return error("Argument #4 of Http.Request must be a string.") end 


     local Connection = Promise.new(function(Resolve, Reject)
        local Success, Result = pcall(function()
            return HttpService:RequestAsync({
                Url = Url,
                Method = Method,
                Headers = Headers,
                Body = Body,
            }) 
        end)

        if(Success)then
            Resolve(Result)
        else
            Reject(Result)
        end
    end)

    return Connection:await()
end

function Http.Get(Endpoint, Headers, Body)
    local Success, Connection = Http.Request(string.format(Http.BASE_URL, Endpoint), "GET", Headers, Body)
    return Success, Connection
end

function Http.Post(Endpoint, Headers, Body)
    local Success, Connection = Http.Request(string.format(Http.BASE_URL, Endpoint), "POST", Headers, Body)
    return Success, Connection
end

function Http.Encode(Table)
    return HttpService:JSONEncode(Table)
end

function Http.Decode(Table)
    return HttpService:JSONDecode(Table)
end

return Http
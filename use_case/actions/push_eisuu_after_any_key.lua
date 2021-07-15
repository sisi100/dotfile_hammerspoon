local PushEisuuAfterAnyKey = {}

PushEisuuAfterAnyKey.new =function(key)
    local func = function()
        hs.alert.show(string.upper(key) .. " & ENG")
        hs.eventtap.event.newKeyEvent({}, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post()
    end
    return func
end

return PushEisuuAfterAnyKey

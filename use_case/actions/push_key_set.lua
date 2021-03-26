local PushKeySet = {}

PushKeySet.new =function(keySet)
    -- keySet: KeySet

    local func = function()
        hs.eventtap.event.newKeyEvent(
            keySet.modifiers,
            string.lower(keySet.key),
            true
        ):post()
    end
    return func
end

return PushKeySet



local KeySet = {}

KeySet.new = function(modifiers, key)
    local obj = {}

    obj.modifiers = modifiers or {} -- e.g. `{"ctrl"}`
    obj.key = key -- e.g. `a`

    return obj
end

return KeySet

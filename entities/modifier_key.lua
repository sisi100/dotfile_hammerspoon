local ModifierKey = {}

ModifierKey.new = function(modifier)
    local obj = {}

    obj.modifier = modifier -- e.g. `"ctrl"`

    return obj
end

return ModifierKey

-- 修飾キーを表すエンティティ
-- キーボードの修飾キー（Ctrl, Alt, Command等）を管理する
local ModifierKey = {}

ModifierKey.new = function(modifier)
    local obj = {}

    -- 修飾キー（例："ctrl"）
    obj.modifier = modifier

    return obj
end

return ModifierKey

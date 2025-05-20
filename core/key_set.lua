-- キーセットを表すエンティティ
-- 修飾キー（Ctrl, Alt, Command等）とキーの組み合わせを管理する
local KeySet = {}

KeySet.new = function(modifiers, key)
    local obj = {}

    -- 修飾キーの配列（例：{"ctrl"}）
    obj.modifiers = modifiers or {}
    -- キー（例："a"）
    obj.key = key

    return obj
end

return KeySet

-- アクションの定義
-- キーバインドに紐づく各種アクションを管理する
local Actions = {}

-- 設定値
local CONFIG = {
    KEYBOARD = {
        DOUBLE_TAP_TIMEOUT = 0.5,  -- ダブルタップの判定時間（秒）
    },
    UI = {
        SHOW_ALERTS = true,  -- アラート表示の有効/無効
    }
}

-- 内部状態
local State = {
    doubleTapStates = {}  -- 修飾キーのダブルタップ状態管理
}

-- キーボードイベントの送信
local function sendKeyboardEvent(modifiers, key, isKeyDown)
    local success, err = pcall(function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), isKeyDown):post()
    end)
    if not success then
        hs.alert.show("キーボードイベントの送信に失敗しました: " .. tostring(err))
    end
end

-- 指定されたキーを押した後に英数キーを押すアクション
Actions.pushEisuuAfterKey = function(key)
    return function()
        if CONFIG.UI.SHOW_ALERTS then
            hs.alert.show(string.upper(key) .. " & ENG")
        end
        sendKeyboardEvent({}, key, true)
        sendKeyboardEvent({}, "eisu", true)
    end
end

-- 指定されたキーを押すアクション
Actions.pushKey = function(keySet)
    return function()
        sendKeyboardEvent(keySet.modifiers, keySet.key, true)
    end
end

-- ウィンドウを最大化するアクション
Actions.maximizeWindow = function()
    return function()
        local success, err = pcall(function()
            hs.grid.maximizeWindow()
        end)
        if not success then
            hs.alert.show("ウィンドウの最大化に失敗しました: " .. tostring(err))
        end
    end
end

-- アプリケーションを起動するアクション
Actions.openApplication = function(appName)
    return function()
        -- 英数入力に切り替え
        sendKeyboardEvent({}, "eisu", true)

        -- アプリケーションを起動
        local success, err = pcall(function()
            hs.execute("open -a " .. appName)
        end)
        if not success then
            hs.alert.show("アプリケーションの起動に失敗しました: " .. tostring(err))
        end
    end
end

-- 修飾キーのダブルタップ状態を管理
local function getDoubleTapState(modifierKey)
    local key = modifierKey.modifier
    if not State.doubleTapStates[key] then
        State.doubleTapStates[key] = {
            isStandby = false,
            timer = nil
        }
    end
    return State.doubleTapStates[key]
end

-- スタンバイ状態を解除
local function cancelStandby(state)
    if state.timer then
        state.timer:stop()
        state.timer = nil
    end
    state.isStandby = false
end

-- 修飾キーを2回押したときのアクション
Actions.doubleTapModifier = function(modifierKey, action)
    local state = getDoubleTapState(modifierKey)

    return function(event)
        local eventType = event:getType()
        local flags = event:getFlags()
        local fixKey = string.gsub(modifierKey.modifier, "right", "")

        -- 修飾キーが押された時
        if eventType == hs.eventtap.event.types.flagsChanged and flags[fixKey] then
            -- 初回タップの場合
            if not state.isStandby then
                state.isStandby = true
                state.timer = hs.timer.doAfter(CONFIG.KEYBOARD.DOUBLE_TAP_TIMEOUT, function()
                    cancelStandby(state)
                end)
                return
            end

            -- ダブルタップの実行
            cancelStandby(state)
            local success, err = pcall(action)
            if not success then
                hs.alert.show("アクションの実行に失敗しました: " .. tostring(err))
            end
        end
    end
end

-- 設定の更新
function Actions.updateConfig(newConfig)
    if type(newConfig) ~= "table" then
        return false, "設定はテーブルである必要があります"
    end

    for category, values in pairs(newConfig) do
        if CONFIG[category] and type(values) == "table" then
            for key, value in pairs(values) do
                if CONFIG[category][key] ~= nil then
                    CONFIG[category][key] = value
                end
            end
        end
    end

    return true
end

return Actions

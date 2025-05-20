-- マウス関連の機能を管理するモジュール
local Mouse = {}

-- 設定値
local CONFIG = {
    SCROLL = {
        MULTIPLIER = -4,  -- スクロール速度の倍率
    },
    UI = {
        SHOW_ALERTS = true,  -- アラート表示の有効/無効
    },
    EVENTS = {
        DOUBLE_CLICK_TIMEOUT = 0.5,  -- ダブルクリック判定のタイムアウト（秒）
    }
}

-- 内部状態
local State = {
    isDeferred = false,      -- 右クリックの遅延状態
    oldMousePosition = {},   -- マウス位置の保存用
    eventListeners = {}      -- イベントリスナーの管理
}

-- イベントリスナーの管理
local function startEventListeners()
    for _, listener in pairs(State.eventListeners) do
        listener:start()
    end
end

local function stopEventListeners()
    for _, listener in pairs(State.eventListeners) do
        listener:stop()
    end
end

-- マウスモジュールの初期化
function Mouse.init()
    startEventListeners()
end

-- 右クリックボタンダウンイベント
State.eventListeners.rightMouseDown = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDown},
    function(event)
        if CONFIG.UI.SHOW_ALERTS then
            hs.alert.show("down")
        end
        State.isDeferred = true
        return true
    end
)

-- 右クリックボタンアップイベント
State.eventListeners.rightMouseUp = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseUp},
    function(event)
        if CONFIG.UI.SHOW_ALERTS then
            hs.alert.show("up")
        end

        if State.isDeferred then
            -- イベントリスナーを一時停止
            stopEventListeners()

            -- 右クリックイベントを発火
            local success, err = pcall(function()
                hs.eventtap.rightClick(event:location())
            end)

            if not success then
                hs.alert.show("右クリックイベントの実行に失敗しました: " .. tostring(err))
            end

            -- イベントリスナーを再開
            startEventListeners()
            return true
        end
        return false
    end
)

-- 右クリックドラッグでスクロールイベント
State.eventListeners.rightMouseDragged = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDragged},
    function(event)
        State.isDeferred = false
        State.oldMousePosition = hs.mouse.absolutePosition()

        -- マウスの移動量を取得
        local deltaX = event:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
        local deltaY = event:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])

        -- スクロールイベントを作成
        local scrollEvent = hs.eventtap.event.newScrollEvent(
            {deltaX * CONFIG.SCROLL.MULTIPLIER, deltaY * CONFIG.SCROLL.MULTIPLIER},
            {},
            "pixel"
        )

        -- マウス位置を元に戻す
        local success, err = pcall(function()
            hs.mouse.absolutePosition(State.oldMousePosition)
        end)

        if not success then
            hs.alert.show("マウス位置の復元に失敗しました: " .. tostring(err))
        end

        return true, {scrollEvent}
    end
)

-- 設定の更新
function Mouse.updateConfig(newConfig)
    for category, values in pairs(newConfig) do
        if CONFIG[category] then
            for key, value in pairs(values) do
                CONFIG[category][key] = value
            end
        end
    end
end

return Mouse

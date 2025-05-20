-- マウス関連の機能を管理するモジュール
local Mouse = {}

-- 設定値
local SCROLL_MULTIPLIER = -4  -- スクロール速度の倍率
local SHOW_ALERTS = true      -- アラート表示の有効/無効

-- 内部状態
local isDeferred = false      -- 右クリックの遅延状態
local oldMousePosition = {}   -- マウス位置の保存用

-- マウスモジュールの初期化
function Mouse.init()
    Mouse.overrideRightMouseDown:start()
    Mouse.overrideRightMouseUp:start()
    Mouse.dragRightToScroll:start()
end

-- 右クリックボタンダウンイベント
Mouse.overrideRightMouseDown = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDown},
    function(event)
        if SHOW_ALERTS then
            hs.alert.show("down")
        end
        isDeferred = true
        return true
    end
)

-- 右クリックボタンアップイベント
Mouse.overrideRightMouseUp = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseUp},
    function(event)
        if SHOW_ALERTS then
            hs.alert.show("up")
        end

        if isDeferred then
            -- イベントリスナーを一時停止
            Mouse.overrideRightMouseDown:stop()
            Mouse.overrideRightMouseUp:stop()

            -- 右クリックイベントを発火
            hs.eventtap.rightClick(event:location())

            -- イベントリスナーを再開
            Mouse.overrideRightMouseDown:start()
            Mouse.overrideRightMouseUp:start()
            return true
        end
        return false
    end
)

-- 右クリックドラッグでスクロールイベント
Mouse.dragRightToScroll = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDragged},
    function(event)
        isDeferred = false
        oldMousePosition = hs.mouse.absolutePosition()

        -- マウスの移動量を取得
        local deltaX = event:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
        local deltaY = event:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])

        -- スクロールイベントを作成
        local scrollEvent = hs.eventtap.event.newScrollEvent(
            {deltaX * SCROLL_MULTIPLIER, deltaY * SCROLL_MULTIPLIER},
            {},
            "pixel"
        )

        -- マウス位置を元に戻す
        hs.mouse.absolutePosition(oldMousePosition)

        return true, {scrollEvent}
    end
)

return Mouse

-- キーボードショートカットの設定ファイル
-- 各種キーバインドとそのアクションを定義する

-- エンティティの読み込み
local KeySet = require("core.key_set")
local ModifierKey = require("core.modifier_key")
local Actions = require("core.actions")

-- キーセットの定義
-- コントロールキー + アルファベット
local ctrl_j = KeySet.new({"ctrl"}, "j")
local ctrl_n = KeySet.new({"ctrl"}, "n")
local ctrl_p = KeySet.new({"ctrl"}, "p")
local ctrl_m = KeySet.new({"ctrl"}, "m")

-- その他のキーセット
local command_m = KeySet.new({"command"}, "m") -- 既存だと`最小化`が入っているけれども、使わないし誤爆すると面倒なので上書きする
local option_space = KeySet.new({"rightalt"}, "space")
local up = KeySet.new({}, "up")
local down = KeySet.new({}, "down")
local righOption = ModifierKey.new("rightalt")
local righCommand = ModifierKey.new("rightcmd")

-- アクションのインスタンス作成
local showHelloWorld = function() hs.alert.show("Hello World !!") end
local pushEisuuAndEscape = Actions.pushEisuuAfterKey("escape")
local pushUp = Actions.pushKey(up)
local pushDown = Actions.pushKey(down)
local windowMaximSize = Actions.maximizeWindow()
local openLaunchpad = Actions.openApplication("launchpad")
local openTerminal = Actions.openApplication("terminal")
local openMissionControl = Actions.openApplication("'Mission Control'")

-- ホットキーの設定
local function setupHotkeys()
    -- キーバインドの設定
    hs.hotkey.bind(command_m.modifiers, command_m.key, showHelloWorld) -- 動作テスト
    hs.hotkey.bind(ctrl_j.modifiers, ctrl_j.key, pushEisuuAndEscape) -- Ctrl+JでEscapeキーを押して英数入力に切り替え
    hs.hotkey.bind(ctrl_p.modifiers, ctrl_p.key, pushUp) -- Ctrl+Pで上矢印キー
    hs.hotkey.bind(ctrl_n.modifiers, ctrl_n.key, pushDown) -- Ctrl+Nで下矢印キー
    -- hs.hotkey.bind(ctrl_m.modifiers, ctrl_m.key, windowMaximSize) -- Ctrl+Mでウィンドウを最大化
    -- hs.hotkey.bind(option_space.modifiers, option_space.key, openMissionControl) -- 右Option+SpaceでMission Control
end

-- イベントの設定
local function setupEvents()
    -- 修飾キーのダブルクリック設定
    local rightOptionEvent = hs.eventtap.new(
        {hs.eventtap.event.types.flagsChanged},
        Actions.doubleTapModifier(righOption, openLaunchpad)
    )
    rightOptionEvent:start()

    local rightCommandEvent = hs.eventtap.new(
        {hs.eventtap.event.types.flagsChanged},
        Actions.doubleTapModifier(righCommand, openTerminal)
    )
    rightCommandEvent:start()
end

-- 初期化関数
local function init()
    setupHotkeys()
    setupEvents()
end

return init

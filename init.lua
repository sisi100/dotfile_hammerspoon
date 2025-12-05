-- Hammerspoon設定ファイルのエントリーポイント
-- 各種設定の初期化を行う

-- アラートのスタイル設定
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.radius = 8
hs.alert.defaultStyle.fadeInDuration = 0.1
hs.alert.defaultStyle.fadeOutDuration = 0.3
hs.alert.defaultStyle.fillColor = { white = 0.1, alpha = 0.85 }
hs.alert.defaultStyle.textColor = { white = 1, alpha = 1 }
hs.alert.defaultStyle.textSize = 14

-- キーバインドの設定を初期化
local initKeyBindings = require("bindings.key")
initKeyBindings()

-- モジュールの読み込み
local Mouse = require("bindings.mouse")

-- マウスモジュールの初期化
Mouse.init()

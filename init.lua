-- Hammerspoon設定ファイルのエントリーポイント
-- 各種設定の初期化を行う

-- キーバインドの設定を初期化
local initKeyBindings = require("bindings.key")
initKeyBindings()

-- モジュールの読み込み
local Mouse = require("bindings.mouse")

-- マウスモジュールの初期化
Mouse.init()

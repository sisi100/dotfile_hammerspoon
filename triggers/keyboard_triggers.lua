-- keyの組み合わせの定義
local KeySet = require "entities.key_set"

local ctrl_z = KeySet.new({"ctrl"}, "z")
local ctrl_j = KeySet.new({"ctrl"}, "j")
local ctrl_n = KeySet.new({"ctrl"}, "n")
local ctrl_p = KeySet.new({"ctrl"}, "p")
local ctrl_m = KeySet.new({"ctrl"}, "m")
local up = KeySet.new({}, "up")
local down = KeySet.new({}, "down")

-- Actionの定義
local HelloInput = require "use_case.inputs.hello_input"
local PushEisuuAfterAnyKeyInput = require "use_case.inputs.push_eisuu_after_any_key_input"
local PushKeyInput = require "use_case.inputs.push_key_set_input"
local WindowMaximSizeInput = require "use_case.inputs.window_maxim_size_input"

local showHelloWorld = HelloInput.new("Hello World !!")
local pushEisuuAndEscape = PushEisuuAfterAnyKeyInput.new("escape")
local pushUp = PushKeyInput.new(up)
local pushDown = PushKeyInput.new(down)
local windowMaximSize = WindowMaximSizeInput.new()

-- ホットキーに設定
local Hotkey = require "use_case.hotkey"

Hotkey.set(ctrl_z, showHelloWorld) -- 動作テスト
Hotkey.set(ctrl_j, pushEisuuAndEscape)
Hotkey.set(ctrl_p, pushUp)
Hotkey.set(ctrl_n, pushDown)
Hotkey.set(ctrl_m, windowMaximSize)

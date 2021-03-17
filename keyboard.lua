local kf = require "keyboard_func"

-- 半角英数へ変更
kf.remapKey({"ctrl"}, "j", kf.pushEisuuAfterAnyKey("escape"))
kf.remapKey({"ctrl"}, "m", kf.pushEisuuAfterAnyKey("return"))

-- カーソル移動
kf.remapKey({"ctrl"}, "n", kf.pushModifierKey("down"))
kf.remapKey({"ctrl"}, "p", kf.pushModifierKey("up"))

-- アプリケーションウィンドウ起動時の選択
for i = 1, 9 do
    kf.remapKey({"option"}, tostring(i), kf.moveAppWindow(i))
end

-- ウィンドウ最大化
hs.hotkey.bind({"cmd"}, "m", hs.grid.maximizeWindow)

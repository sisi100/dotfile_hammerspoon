local ExecuteCommand = {}

ExecuteCommand.new =function(shellCommand)
    -- shellCommand:string シェルのコマンド。例：open .

    local func = function()
        hs.eventtap.event.newKeyEvent({}, KEY_CODE_JIS_EISUU, true):post() -- 英数に戻す
        hs.execute(shellCommand)
    end
    return func
end

return ExecuteCommand

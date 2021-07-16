local ExecuteCommand = {}

ExecuteCommand.new = function(shellCommand)
    -- shellCommand:string シェルのコマンド。例：`open .`

    local func = function()
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post() -- 英数に戻す
        hs.execute(shellCommand)
    end
    return func
end

return ExecuteCommand

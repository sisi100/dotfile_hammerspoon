local ExecuteCommand = require "use_case.actions.execute_command"
local ExecuteCommandInput = {}

ExecuteCommandInput.new = function(shellCommand)
    return ExecuteCommand.new(shellCommand)
end

return ExecuteCommandInput

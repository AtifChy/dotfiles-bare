require "settings"

local async
async =
    vim.loop.new_async(
    vim.schedule_wrap(
        function()
            require "plugin"
            require "keybinds"

            async:close()
        end
    )
)
async:send()

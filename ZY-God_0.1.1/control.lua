-- control.lua控制游戏逻辑的代码，例如事件处理、物体生成和游戏规则。

-- 在控制文件中预先引入所有模块
local custom_events = require("custom_events")
local custom_exjmuyhi = require("custom_exjmuyhi")

-- 定义 "mm-Love" 事件处理函数
function mmLoveEventHandler(event)
    custom_events.mmLoveEventHandler(event)  -- 使用模块返回的表来访问事件处理函数
    custom_exjmuyhi.someFunction(event) -- 使用 "custom_exjmuyhi.lua" 模块中的函数或方法
end

-- 监听 "mm-Love" 事件
script.on_event("mm-Love", mmLoveEventHandler)

-- 监听 "mm-Love" 事件
script.on_event("mm-Love-move", someFunction)

-- 鼠标中键=启动或禁用MODS

-- 定义一个全局状态变量，用于控制是否启用 "mm-Love" 事件
global.mmLoveEnabled = true -- 初始化时默认启用事件

-- 监听 "mm-Love-move-itme" 事件，根据状态变量控制是否启用 "mm-Love" 和 "mm-Love-move" 事件
script.on_event("mm-Love-move-itme", function(event)
    local player = game.players[event.player_index]
    global.mmLoveEnabled = not global.mmLoveEnabled -- 切换状态变量的值

    if global.mmLoveEnabled then
        player.print("启用，狂雷和传送阵 ")
        -- 在此处重新绑定 "mm-Love" 事件
        script.on_event("mm-Love", mmLoveEventHandler)
        script.on_event("mm-Love-move", someFunction) -- 同时绑定 "mm-Love-move" 事件
    else
        player.print("禁用，狂雷和传送阵 ")
        -- 在此处取消绑定 "mm-Love" 事件
        script.on_event("mm-Love", nil)
        script.on_event("mm-Love-move", nil) -- 同时取消绑定 "mm-Love-move" 事件
    end
    player.print("mmLoveEnabled 值为：" .. tostring(global.mmLoveEnabled)) -- 输出状态变量的值
end)

-- 在初始时初始化事件处理
script.on_init(function()
    -- 在初始化时，根据状态变量的值绑定或取消绑定 "mm-Love" 和 "mm-Love-move" 事件
    if global.mmLoveEnabled then
        script.on_event("mm-Love", mmLoveEventHandler)
        script.on_event("mm-Love-move", someFunction) -- 同时绑定 "mm-Love-move" 事件
    else
        script.on_event("mm-Love", nil)
        script.on_event("mm-Love-move", nil) -- 同时取消绑定 "mm-Love-move" 事件
    end
end)

-- 在MODS状态变化时重新绑定 "mm-Love" 和 "mm-Love-move" 事件
script.on_configuration_changed(function(data)
    -- 在 MODS 状态变化时，根据状态变量的值重新绑定或取消绑定 "mm-Love" 和 "mm-Love-move" 事件
    if global.mmLoveEnabled then
        script.on_event("mm-Love", mmLoveEventHandler)
        script.on_event("mm-Love-move", someFunction) -- 同时绑定 "mm-Love-move" 事件
    else
        script.on_event("mm-Love", nil)
        script.on_event("mm-Love-move", nil) -- 同时取消绑定 "mm-Love-move" 事件
    end
end)


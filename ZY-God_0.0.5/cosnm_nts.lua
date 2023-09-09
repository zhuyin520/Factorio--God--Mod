-- cosnm_nts.lua
-- 鼠标中键触发=启动或禁用MODS

-- 定义一个全局状态变量，启动或禁用 MODS 的全局状态变量
script.on_init(function()
    global.mmLoveEnabled = true -- 初始化时默认启用事件
end)

-- 定义事件处理函数
function toggleMMLoveEvents(player)
    if global.mmLoveEnabled then
        script.on_event("mm-Love", mmLoveEventHandler)
        script.on_event("mm-Love-move", mmLoveMoveEventHandler)
        player.print("启用 mm-Love 和 mm-Love-move 事件")
        game.print("启用 mm-Love 和 mm-Love-move 事件")
    else
        script.on_event("mm-Love", nil)
        script.on_event("mm-Love-move", nil)
        player.print("禁用 mm-Love 和 mm-Love-move 事件")
        game.print("禁用 mm-Love 和 mm-Love-move 事件")
    end
    player.print("mmLoveEnabled 值为：" .. tostring(global.mmLoveEnabled)) -- 输出状态变量的值
end

-- 监听 "mm-Love-move-itme-womk" 事件，根据状态变量控制事件的启用和禁用
script.on_event("mm-Love-move-itme", function(e)
    local player = game.players[e.player_index]
    global.mmLoveEnabled = not global.mmLoveEnabled -- 切换状态变量的值
    toggleMMLoveEvents(player)
end)

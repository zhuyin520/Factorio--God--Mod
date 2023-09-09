-- custom_events.lua
-- 鼠标左键=狂雷

-- 在 custom_events.lua 中存储玩家上次点击的位置
local player_last_click_positions = {}

-- 在 custom_events.lua 中添加数据
table.insert(player_last_click_positions, {x = 30, y = 40})

-- 在 custom_events.lua 中读取数据
local lastClick = player_last_click_positions[#player_last_click_positions]

-- 监听 "mm-Love" 事件，处理投掷胶囊的逻辑
script.on_event("mm-Love", function(event)
    -- 获取玩家
    local player = game.players[event.player_index]

    -- 确保 "MM_Thunder" 是你的 Mod 中正确定义的胶囊物品名称
    local capsule_name = "MM_Thunder" -- 你的胶囊名称

    -- 获取玩家上次点击的位置
    local last_click_position = player_last_click_positions[player.index]

    if last_click_position then
        -- 创建一个名为 "your_capsule_name" 的胶囊物品栈
        local capsule_stack = {
            name = capsule_name,
            count = 1,
            health = 1, -- 如果需要指定血量
            durability = 1 -- 如果需要指定耐久度
        }

        -- 获取玩家的位置
        local player_position = player.position

        -- 计算投掷的方向
        local throw_direction = {x = last_click_position.x - player_position.x, y = last_click_position.y - player_position.y}

        -- 创建一个胶囊实体并设置位置
        local capsule_entity = game.surfaces[player.surface.name].create_entity({
            name = capsule_name,
            position = player.position,
            force = player.force,
            target = last_click_position,
            speed = 1 -- 投掷速度
        })

        if capsule_entity then
            -- 移除玩家背包中的胶囊
            player.remove_item(capsule_stack)
        end
    end
end)

-- 监听玩家的鼠标点击事件，记录点击位置
script.on_event(defines.events.on_player_selected_area, function(event)
    local player = game.players[event.player_index]
  
    -- 检查是否有有效的点击区域
    if event.area then
        player_last_click_positions[player.index] = event.area.left_top
    end
end)

-- 在 on_selected_entity_changed 事件中清除记录
script.on_event(defines.events.on_selected_entity_changed, function(event)
    local player = game.players[event.player_index]
    local selected_entity = player.selected

    if not selected_entity or not selected_entity.valid then
        -- 如果没有选择实体或者选择的实体无效，则清除记录
        player_last_click_positions[player.index] = nil
    end
end)



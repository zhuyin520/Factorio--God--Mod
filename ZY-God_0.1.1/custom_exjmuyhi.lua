-- custom_exjmuyhi.lua
-- 鼠标右键=瞬移
local function someFunction(event)--consm_nts.lua逻辑来控制下面的代码

-- 在 custom_exjmuyhi.lua 中存储玩家上次点击的位置
local player_last_click_positions = {}

-- 在 custom_exjmuyhi.lua 中添加数据
table.insert(player_last_click_positions, {x = 10, y = 20})

-- 在 custom_exjmuyhi.lua 中读取数据
local lastClick = player_last_click_positions[#player_last_click_positions]

-- 在 custom_exjmuyhi.lua 中初始化 global.targets
if not global.targets then
  global.targets = {}
end

-- 初始化全局变量
global.hasPrintedMoveInfo = {}
global.hasPrintedMoveLeftInfo = {}
global.moveInfoCount = {}
global.teleporting2Entities = {}

-- 清除所有绘制的精灵
local function clear_sprites(config)
  if config.sprites then
    for _, s in pairs(config.sprites) do
      rendering.destroy(s)
    end
    config.sprites = {}
  end
end

-- 在玩家位置绘制目标标记
local function draw_target(player, position)
  local size = 0.3
  return {
    rendering.draw_circle {
      color = {r = 0, g = 1, b = 0},
      radius = size / 1.5,
      width = 1,
      filled = false,
      target = position,
      surface = player.surface,
      players = {player}
    },
    rendering.draw_line {
      color = {r = 0, g = 1, b = 0},
      width = 1,
      from = {x = position.x - size, y = position.y},
      to = {x = position.x + size, y = position.y},
      surface = player.surface,
      players = {player}
    },
    rendering.draw_line {
      color = {r = 0, g = 1, b = 0},
      width = 1,
      from = {x = position.x, y = position.y - size},
      to = {x = position.x, y = position.y + size},
      surface = player.surface,
      players = {player}
    }
  }
end

-- 根据位置获取方向
local function get_direction(from, to, distance)
  local dx = from.x - to.x
  local dy = from.y - to.y
  if dx > distance then
    -- 西方
    if dy > distance then
      return defines.direction.northwest
    elseif dy < -distance then
      return defines.direction.southwest
    else
      return defines.direction.west
    end
  elseif dx < -distance then
    -- 东方
    if dy > distance then
      return defines.direction.northeast
    elseif dy < -distance then
      return defines.direction.southeast
    else
      return defines.direction.east
    end
  else
    -- 北/南方向
    if dy > distance then
      return defines.direction.north
    elseif dy < -distance then
      return defines.direction.south
    end
  end
  return nil
end

-- 根据位置获取驾驶状态
local function get_riding_state(v, o, t)
  local radians = o * 2 * math.pi
  local angle = radians + math.pi / 2
  local perp_angle = radians

  local v1 = {x = t.x - v.x, y = t.y - v.y}
  local dir = v1.x * math.sin(angle) - v1.y * math.cos(angle)
  local acc = v1.x * math.sin(perp_angle) - v1.y * math.cos(perp_angle)

  local res = {}
  if dir < -0.2 then
    res.dir = defines.riding.direction.left
  elseif dir > 0.2 then
    res.dir = defines.riding.direction.right
  else
    res.dir = defines.riding.direction.straight
  end

  -- 鼠标悬停在车辆上时制动
  if v1.x * v1.x + v1.y * v1.y < 2 then 
    res.acc = defines.riding.acceleration.braking
  elseif acc < -0.2 then
    res.acc = defines.riding.acceleration.reversing
  elseif acc > 0.2 then
    res.acc = defines.riding.acceleration.accelerating
  else
    res.acc = defines.riding.acceleration.braking
  end

  return {direction = res.dir, acceleration = res.acc}
end

-- 监听玩家的鼠标点击事件，记录点击位置
script.on_event(defines.events.on_player_mined_item, function(event)
  local player = game.players[event.player_index]

  -- 检查是否有有效的点击区域
  if event.area then
      player_last_click_positions[player.index] = event.area.left_top
  end
end)

-- 在 on_selected_entity_changed 事件中清除记录
script.on_event(defines.events.on_player_mined_entity, function(event)
  local player = game.players[event.player_index]
  local selected_entity = player.selected

  if not selected_entity or not selected_entity.valid then
      -- 如果没有选择实体或者选择的实体无效，则清除记录
      player_last_click_positions[player.index] = nil
  end
end)

-- 监听 "mm-Love-move" 事件，处理投掷胶囊的逻辑
script.on_event(
    "mm-Love-move",
    function(e)
        local player = game.players[e.player_index]

        if player.driving then
            player.teleport(e.cursor_position)  -- 使用 teleport 函数瞬移到目标位置
        else
            player.teleport(e.cursor_position)  -- 同样可以在步行状态下瞬移到目标位置

            -- 确保 "MM_chuanshong" 是你的 Mod 中正确定义的胶囊物品名称
            local capsule_name = "MM_chuanshong" -- 你的胶囊名称

                -- 获取玩家上次点击的位置
            local last_click_position = player_last_click_positions[player.index]

             if last_click_position then
                -- 创建一个名为 "your_capsule_name" 的胶囊物品栈
                local capsule_stack = {
                    name = "MM_chuanshong",
                    count = 1,
                    health = 1, -- 如果需要指定血量
                    durability = 1 -- 如果需要指定耐久度
                }
              
                  -- 获取玩家的位置
                local player_position = player.position

                  -- 计算投掷的方向并规范化
                local throw_direction = {
                    x = last_click_position.x - (player_position.x + 0.1),
                    y = last_click_position.y - (player_position.y + 0.1)
                }

                  -- 规范化方向向量
                local length = math.sqrt(throw_direction.x * throw_direction.x + throw_direction.y * throw_direction.y)
                throw_direction.x = throw_direction.x / length
                throw_direction.y = throw_direction.y / length

                  -- 计算目标位置为玩家脚下中心点
                local target_position = {
                    x = player_position.x + 0.1,
                    y = player_position.y + 0.1
                }

                  -- 创建一个胶囊实体并设置位置
                local capsule_entity = game.surfaces[player.surface.name].create_entity({
                    name = "MM_chuanshong",
                    position = player.position,
                    force = player.force,
                    target = target_position, -- 将目标位置设置为脚下中心点
                    speed = 1 -- 投掷速度
                })

                if capsule_entity then
                    -- 移除玩家背包中的胶囊
                    player.remove_item(capsule_stack)
                end
              end
        end
    end
)

-- 检查玩家角色是否存在且有效
script.on_event(           -- 玩家角色走路会触发
  defines.events.on_tick,
  function()
    for i, config in pairs(global.targets) do
      local player = game.players[i]
      -- 检查玩家角色是否存在且有效
      if config.target and player and player.valid then
        if player.driving then
          if get_direction(player.position, config.target, 6) then
            player.riding_state =
              get_riding_state(player.vehicle.position, player.vehicle.orientation, config.target)
          else
            player.riding_state = {
              direction = defines.riding.direction.straight,
              acceleration = defines.riding.acceleration.braking
            }
            clear_sprites(config)
            config.target = nil
          end
        else
          local direction = get_direction(player.position, config.target, 0.1)
          if direction then
            player.walking_state = {walking = true, direction = direction}
          else
            clear_sprites(config)
            config.target = nil
          end
        end
      end
    end
  end
)
  -- 在这里编写 "mm-Love-move" 事件的具体逻辑
end
-- 返回包含事件处理函数的表
return {
  someFunction = someFunction
}
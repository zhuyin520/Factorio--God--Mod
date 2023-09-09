-- control.lua
-- Ctrl + 鼠标右键=瞬移

-- 初始化全局变量
global.hasPrintedMoveInfo = {}
global.hasPrintedMoveLeftInfo = {}
global.moveInfoCount = {}
global.teleporting2Entities = {}

-- 在初始化时为全局变量分配空表
script.on_init(
  function()
    global.targets = {}
    global.teleporting2Entities = {}  -- 初始化存储生成的 teleporting2 实体的表
  end
)

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

-- 监听 "mm-move" 事件，处理鼠标点击移动操作
script.on_event(
  "mm-move",
  function(e)
    if global.targets[e.player_index] == nil then
      global.targets[e.player_index] = {}
    end
    local config = global.targets[e.player_index]
    local player = game.players[e.player_index]
    clear_sprites(config)
    config.target = e.cursor_position
    config.sprites = draw_target(player, e.cursor_position)

    -- 初始化 moveInfoCount 和 hasPrintedMoveInfo 变量
    global.moveInfoCount = global.moveInfoCount or {}
    global.hasPrintedMoveInfo = global.hasPrintedMoveInfo or {}

    if not global.moveInfoCount[e.player_index] then
      global.moveInfoCount[e.player_index] = 0
    end
    if not global.hasPrintedMoveInfo[e.player_index] then
      global.hasPrintedMoveInfo[e.player_index] = false
    end

    -- 在这里添加处理右键点击的逻辑
    if player.driving then
      player.teleport(e.cursor_position)  -- 使用 teleport 函数瞬移到目标位置
    else
      player.teleport(e.cursor_position)  -- 同样可以在步行状态下瞬移到目标位置

      --检查来确保 player 变量的有效性
      if player.character and player.character.valid then
        -- 在人物脚下生成 teleporting2 物品，并使其在脚底中心点
        local position = player.position
        local entity_height = player.character.prototype.selection_box and player.character.prototype.selection_box.height or 0
        local item = player.surface.create_entity{
          name = "teleporting2",
          position = {x = position.x, y = position.y + entity_height / 2},
          force = "player"
        }
        -- 存储生成的 teleporting2 实体
        if item and item.valid then
          if not global.teleporting2Entities then
            global.teleporting2Entities = {}
          end

          if not global.teleporting2Entities[e.player_index] then
            global.teleporting2Entities[e.player_index] = {}
          end

          table.insert(global.teleporting2Entities[e.player_index], item)

          -- 限制 teleporting2 实体数量，销毁第一个实体
          if #global.teleporting2Entities[e.player_index] > 4 then
            local firstEntity = table.remove(global.teleporting2Entities[e.player_index], 1)
            if firstEntity and firstEntity.valid then
              firstEntity.destroy()
            end
          end
        end
      end
    end
  end        
)

-- 监听 "my-custom-input" 事件，处理玩家点击自定义输入的逻辑
script.on_event(                   -- Ctrl + 鼠标中键触发
  "my-custom-input",
  -- 处理事件的函数
  function(event)
    local player = game.players[event.player_index]
    -- 检查玩家是否离开实体
    if not player.driving then
      -- 玩家离开实体时销毁相应的 teleporting2 实体
      if global.teleporting2Entities and global.teleporting2Entities[event.player_index] then
        for _, entity in pairs(global.teleporting2Entities[event.player_index]) do
          print("Iterating over entity:", entity)  -- 添加这行用于调试
          if entity and entity.valid then
            entity.destroy()
          end
        end        
        global.teleporting2Entities[event.player_index] = {}
        player.print("离开实体，销毁了所有 teleporting2 实体!")
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

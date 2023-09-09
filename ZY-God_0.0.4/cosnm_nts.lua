-- cosnm_nts.lua
-- Ctrl + 鼠标中键触发=启动或禁用MODS
-- 这段代码将在按下鼠标中键时切换鼠标左键和鼠标右键自定义输入的启用或禁用状态
-- 在mod初始化时执行一次的代码
script.on_init(function()
  -- 获取玩家的输入对象
  local player = game.get_player(1)  -- 这里假设你想获取第一个玩家的输入对象

  -- 监听自定义输入事件
  script.on_event("mm-Love-move-itme", function(event)
      -- 检查事件是否为Ctrl + 鼠标右键
      if event.prototype_name == "mm-Love-move-itme" and event.control then
          -- 按下Ctrl + 鼠标右键时切换自定义输入的enabled属性
          player.set_shortcut_toggled("mm-Love", not player.is_shortcut_toggled("mm-Love"))
          player.set_shortcut_toggled("mm-Love-move", not player.is_shortcut_toggled("mm-Love-move"))
      end
  end)
end)

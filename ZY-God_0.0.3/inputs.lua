-- inputs.lua
-- 在这里添加自定义输入定义
data:extend({
  {
    type = "custom-input",
    name = "mm-Love",                    -- 自定义输入的名称
    key_sequence = "mouse-button-1",     -- 鼠标左键
    enabled = true                       -- 设置实体启用状态为true,设置实体禁用状态false
  },
  {
    type = "custom-input",
    name = "mm-Love-move",                    -- 自定义输入的名称
    key_sequence = "mouse-button-2",     -- 鼠标右键
    enabled = true                        -- 设置实体启用状态为true,设置实体禁用状态false
  },
  {
    type = "custom-input",
    name = "mm-Love-move-itme",                -- 自定义输入的名称
    key_sequence = "CONTROL + mouse-button-2", -- Ctrl + 鼠标右键
  
  }
})

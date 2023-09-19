-- inputs.lua
-- 在这里添加自定义输入定义
data:extend({
  {
    type = "custom-input",
    name = "mm-Love",                             -- 自定义输入的名称
    key_sequence = "mouse-button-1",              -- 鼠标左键
    consuming = "none"                            -- 防止阻止默认的鼠标左键事件
  },
  {
    type = "custom-input",
    name = "mm-Love-move",                        -- 自定义输入的名称
    key_sequence = "mouse-button-2",              -- 鼠标右键
    consuming = "none"                            -- 防止阻止默认的鼠标右键事件
  },
  {
    type = "custom-input",
    name = "mm-Love-move-itme",                   -- 自定义输入的名称
    key_sequence = "mouse-button-3",              -- 鼠标中键
    consuming = "none"                            -- 防止阻止默认的鼠标中键事件
  },
  {
    type = "custom-input",                        -- 视图缩放快捷键
    name = "mm-Love-move-itme-womk",              -- 自定义输入的名称
    key_sequence = "SHIFT + c",                   -- SHIFT + c
    consuming = "none"                            -- 防止阻止默认的SHIFT + c事件
  }
})

-- data.lua

--关联item.lua让她像date.lua中一样运行代码
require("item")

-- 在这里添加自定义输入定义
data:extend({
  {
    type = "custom-input",
    name = "mm-move",                -- 自定义输入的名称
    key_sequence = "CONTROL + mouse-button-2", -- Ctrl + 鼠标右键
    consuming = "none" -- 防止阻止默认的Ctrl + 鼠标右键事件
  },
  {
    type = "custom-input",
    name = "my-custom-input",                -- 自定义输入的名称
    key_sequence = "CONTROL + mouse-button-3", -- Ctrl + 鼠标中键（）
    consuming = "none" -- 防止阻止默认的Ctrl + 鼠标中键事件
  }
})




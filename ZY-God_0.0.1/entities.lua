-- entities.lua
-- 定义您的新实体
data:extend({
  {
    type = "simple-entity", -- 您可以使用 "simple-entity" 作为基本类型
    name = "god-lightning-entity-1",
    flags = {"placeable-off-grid", "not-on-map"},
    icon = "__ZY-God__/graphics/God001.png", -- 图片路径
    icon_size = 128,
    render_layer = "object", -- 设置渲染层为 "object"
    max_health = 1, -- 根据需要调整健康值
    pictures =
    {
      {
        filename = "__ZY-God__/graphics/God001.png",
        width = 128,
        height = 128,
        scale = 1,
        shift = {0, 0}, -- 根据需要调整偏移量
      },
      {
        filename = "__ZY-God__/graphics/God002.png",
        width = 128,
        height = 128,
        scale = 1,
        shift = {0, 0}, -- 根据需要调整偏移量
      },
    },
  },
})

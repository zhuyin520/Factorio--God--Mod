--texture.lua

require("prototypes.animation_util")  -- 这段代码扩展了Factorio的数据定义，创建了一个名为 "atsword_majesty-explosion" 的爆炸实体。

data:extend({

    {
        type = "explosion", -- 定义实体的类型为爆炸
        name = "MM_Thunder-explosion", -- 实体的名称
        localised_name = { "MM_Thunder-explosion" }, -- 本地化名称，可能会从游戏的本地化文件中获取
        icon = "__base__/graphics/item-group/effects.png", -- 图标的路径
        icon_size = 64, -- 图标的大小
        flags = { "not-on-map","hidden" }, -- 标志，表示该实体不在地图上可见且隐藏"hidden" 
        subgroup = "explosions", -- 子组
        animations = getStripesAnimation("atsword_majesty/", 30, 298, 426),        -- 动画帧集合，函数动画有多少帧，动画帧之间的间隔时间，动画帧的宽度
    }    
})

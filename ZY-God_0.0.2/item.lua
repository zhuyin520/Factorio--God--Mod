
-- item.lua
-- 创建物品
data:extend({
    {                            --创造顶级组(父组)
        type = "item-group",             --类名
        name = "AcademyofMagic",            --名字
        order = "oa",                        --顺序位置
        icon = "__ZY-God__/graphics/zy/AcademyofMagic.png",   --图标路径
        icon_size = 128,              --图标大小
        icon_mipmaps = 1,             --图标个数
    },
    {                           --创造子级组
        type = "item-subgroup",       --类名
        name = "flower",           --名字
        group = "AcademyofMagic",      --在顶级组定义类名
        order = "a",          --顺序位置
    }
})

-- 图标归为哪一个子组
data:extend({
    {
        type = "item",
        name = "teleporting",
        icon = "__ZY-God__/graphics/zyy/God001.png",
        icon_size = 128,             --图标大小
        icon_mipmaps = 1,            --图标个数
        subgroup = "flower",      --在子级组定义类名
        order = "a",           --顺序
        stack_size = 10,          --代表多少为一组，我这里设置10就代表每10个neroli占一个格子
        place_result = "teleporting", -- 指定放置物品时生成的实体
    },
    {
        type = "item",
        name = "teleporting2",
        icon = "__ZY-God__/graphics/zyy/God002.png",
        icon_size = 128,             --图标大小
        icon_mipmaps = 1,            --图标个数
        subgroup = "flower",      --在子级组定义类名
        order = "a",           --顺序
        stack_size = 10,          --代表多少为一组，我这里设置10就代表每10个neroli占一个格子
        place_result = "teleporting2", -- 指定放置物品时生成的实体
    },
    {
        type = "recipe",
        name = "teleporting",
        enabled = false,             -- 设置实体启用状态为true,设置实体禁用状态false
        ingredients = {              --成分表
            { "stone-brick", 10 }
        },
            energy_required = 1,   -- 时间需求
            result = "teleporting" -- 生成物品
    },
    {
        type = "recipe",
        name = "teleporting2",
        enabled = false,             -- 设置实体启用状态为true,设置实体禁用状态false
        ingredients = {               --成分表
            { "stone-brick", 10 } 
        },          
            energy_required = 1,   -- 时间需求
            result = "teleporting2" -- 生成物品           
    }
})

-- entity.lua
-- 创建实体.碰撞边界参数
data:extend({
    {
        type = "simple-entity", -- 实体类型为简单实体
        name = "teleporting",   -- 实体的名称，与物品定义中的 place_result 对应
        icon = "__ZY-God__/graphics/zyy/God001.png",
        icon_size = 128,         -- 图标的大小
        icon_mipmaps = 1,        -- 图标的 mipmap 层数
        flags = {"placeable-neutral", "player-creation"}, -- 实体的标志，可以放置且玩家可以创建
        render_layer = "object", -- 渲染层级
        collision_box = {{0, 0}, {0, 0}},       -- 碰撞盒大小
        selection_box = {{-0.6, -0.6}, {0.6, 0.6}},       -- 选择盒大小
        picture = {
            layers = {
                {
                    filename = "__ZY-God__/graphics/zyy/God001.png", -- 图片文件路径
                    size = 128,                 -- 图片大小
                    scale = 0.5,                -- 图片缩放比例
                }
            }
        },
        minable = {              -- 设置实体可以被开采（销毁）
            hardness = 0.2,       -- 需要多少时间来开采实体
            mining_time = 0.5,    -- 开采时间
            result = "teleporting" -- 开采结果，即物品名称
        }
    },

    {
        type = "simple-entity", -- 实体类型为简单实体
        name = "teleporting2",  -- 实体的名称，与物品定义中的 place_result 对应
        icon = "__ZY-God__/graphics/zyy/God002.png",
        icon_size = 128,         -- 图标的大小
        icon_mipmaps = 1,        -- 图标的 mipmap 层数
        flags = {"placeable-neutral", "player-creation"}, -- 实体的标志，可以放置且玩家可以创建
        render_layer = "object", -- 渲染层级
        collision_box = {{0, 0}, {0, 0}},       -- 碰撞盒大小
        selection_box = {{-0.6, -0.6}, {0.6, 0.6}},       -- 选择盒大小
        picture = {
            layers = {
                {
                    filename = "__ZY-God__/graphics/zyy/God002.png", -- 图片文件路径
                    size = 128,                 -- 图片大小
                    scale = 0.5,                -- 图片缩放比例
                }
            }
        },
        minable = {              -- 设置实体可以被开采（销毁）
            hardness = 0.2,       -- 需要多少时间来开采实体
            mining_time = 0.5,    -- 开采时间
            result = "teleporting2" -- 开采结果，即物品名称
        }
    }
})


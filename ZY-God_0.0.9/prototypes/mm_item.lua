--mm_item.lua

local mod_path = "__ZY-God__/graphics/"

data:extend(
    {
        {
            type = "projectile",
            name = "MM_Thunder",
            flags = { "not-on-map" },   -- 标志表示在地图上不可见
            acceleration = 2,    -- 加速度
            action = {
                {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "create-entity",
                                entity_name = "MM_Thunder-explosion"
                            },

                            {
                                type = "destroy-decoratives",
                                from_render_layer = "decorative",
                                to_render_layer = "object",
                                include_soft_decoratives = true, -- 包括可穿过铁轨路径的软装饰物
                                include_decals = false,
                                invoke_decorative_trigger = true,
                                decoratives_with_trigger_only = false, -- 如果为 true，仅销毁具有 trigger_effect 设置的装饰物
                                radius = 2.25                    -- 用于演示目的的大半径
                            }
                        }
                    }
                },
                {
                    type = "area",
                    radius = 15,                 -- 伤害范围半径
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 800, type = "explosion" }          -- 造成的伤害类型和伤害数值
                            }                                                           --"physical": 物理伤害。
                        }                                                               --"impact": 冲击伤害，通常用于炮弹和炮击
                    }                                                                   --"explosion": 爆炸伤害，通常用于爆炸物品。
                }                                                                       --"fire": 火焰伤害，通常用于火焰武器和火焰效果。
            },                                                                          --"electric": 电击伤害，通常用于电击武器和电网。
            light = { intensity = 0.5, size = 4 },     -- 发光属性                       --"poison": 毒素伤害，通常用于毒素武器和环境中的毒气。
            animation = {
                filename = "__base__/graphics/entity/grenade/grenade.png",          -- 动画文件路径
                frame_count = 16,
                draw_as_glow = true,          -- 作为发光物体渲染
                frame_count = 16,         -- 帧数
                line_length = 8,         -- 每行的帧数
                animation_speed = 0.250,       -- 动画速度
                width = 26,                       -- 宽度
                height = 28,                         -- 高度
                shift = util.by_pixel(1, 1),         -- 位置偏移
                priority = "high"               -- 优先级

            },
            shadow = {
                filename = "__base__/graphics/entity/grenade/grenade-shadow.png",      -- 阴影文件路径
                frame_count = 16,            -- 帧数    
                line_length = 8,            -- 每行的帧数
                animation_speed = 0.250,     -- 动画速度
                width = 26,                    -- 宽度
                height = 20,                  -- 高度
                shift = util.by_pixel(2, 6),           -- 位置偏移
                priority = "high",           -- 优先级
                draw_as_shadow = true           -- 作为阴影渲染
            }
        },
        {
            type = "capsule",               -- 类型为胶囊
            name = "MM_Thunder",        
            localised_name = "狂雷",          -- 本地化名称
            enabled = false,             -- 设置实体启用状态为true,设置实体禁用状态false            
            icon = mod_path .. "zyyy/Thunder.png",
            icon_size = 64,              --图标大小
            icon_mipmaps = 1,            --图标个数
            subgroup = "flower",         -- 子组
            order = "a-a",          -- 排序顺序
            capsule_action = {
                type = "throw",        -- 类型为投掷
                attack_parameters = {
                    type = "projectile",
                    activation_type = "throw",      -- 激活类型
                    ammo_category = "grenade",      -- 弹药类别
                    cooldown = 30,         -- 冷却时间
                    projectile_creation_distance = 0.6,       -- 投掷物创建距离
                    range = 10000,            -- 射程
                    ammo_type = {
                        category = "grenade",
                        target_type = "position",
                        action = {
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "projectile",
                                    projectile = "MM_Thunder",
                                    starting_speed = 60           -- 初始速度
                                }
                            },
                            -- 这是一个注释
                            --{
                            --    type = "direct",
                            --    action_delivery = {
                            --        type = "instant",
                            --        target_effects = {
                            --            {
                            --                type = "play-sound",
                            --                sound = sounds.throw_projectile
                            --            }
                            --        }
                            --    }
                            --}
                        }
                    }
                }
            },
            stack_size = 100,           --堆叠大小
        }
    }
)

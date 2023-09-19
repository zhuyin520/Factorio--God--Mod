--animation_util.lua

-- 图形文件路径的前缀
local mod_path = "__ZY-God__/graphics/"

-- 获取一组条纹图像的函数
function getStripes(path, max)
    local stripes = {}
    for i = 1, max do
        local s = {
            filename = mod_path .. path .. i .. ".png",-- 构建文件路径
            width_in_frames = 1,
            height_in_frames = 1,
        }
        table.insert(stripes, s) -- 将生成的条纹信息添加到表中
    end
    return stripes -- 返回包含生成的条纹信息的表
end

-- 获取条纹动画的函数
function getStripesAnimation(path, max, width, height)
    local animation = {
        slice = 1,
        priority = "high",
        animation_speed = 0.2, -- 动画播放速度
        width = width, -- 动画帧的宽度
        height = height, -- 动画帧的高度
        frame_count = max, -- 动画帧的总数
        draw_as_glow = true, -- 以发光效果绘制
        direction_count = 1,
        --shift = util.by_pixel(0, -80),
        scale = 1,
        stripes = getStripes(path, max), -- 使用上面的函数获取条纹信息
    }
    return animation -- 返回包含动画配置信息的表
end

--recipe.lua
-- 创建物品()

data:extend(
        {
            { type = "recipe",
              name = "MM_Thunder",
              enabled = false,
              energy_required = 10,
              ingredients = {
                  { "stone", 100 },
              },
              result = "MM_Thunder",
              result_count = 1,
            },
        })
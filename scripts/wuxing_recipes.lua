local recipe_name = "lotus_umbrella"                                    -- 配方唯一名称，不可重复，通常用prefab名
local ingredients = { Ingredient("cutgrass", 1), Ingredient("twigs", 1) } -- 原料表
local tech = TECH.NONE                                                  -- 所需科技，必须使用常量表TECH的值
local config = {
    atlas = "images/inventoryimages/lotus_umbrella.xml",
}
AddRecipe2(recipe_name, ingredients, tech, config)
STRINGS.RECIPE_DESC.LOTUS_UMBRELLA = "荷叶做的雨伞" -- 制作栏描述
--模组配方过滤器
AddRecipeFilter({name="wuxing",atlas="",image=""})
STRINGS.UI.CRAFTING_FILTERS.WUXING ="五行之力" -- 制作栏中显示的名字
--五行祭坛 黄金*50，木板*50，冰雕鱼*1，太阳鱼*1，种子*50
AddRecipe2("wuxing_jitan",
    { Ingredient("goldnugget", 50), Ingredient("boards", 50), Ingredient("boards", 50), Ingredient(
    "oceanfish_medium_8_inv", 1), Ingredient("oceanfish_small_8_inv", 1), Ingredient("seeds", 50) }, TECH.NONE, {atlas="",build_mode=BUILDMODE.LAND},{"wuxing"})

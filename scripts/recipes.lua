--模组配方过滤器
AddRecipeFilter({ name = "wuxing", atlas = "images/wuxing_jitan.xml", image = "wuxing_jitan.tex" })
STRINGS.UI.CRAFTING_FILTERS.WUXING = "五行之力" -- 制作栏过滤器显示的名字

--AddRecipe2.物品，材料，科技，配置(builder_tag, placer, min_spacing, no_deconstruction,numtogive,product,canbuild})，过滤器
--五行祭坛 黄金*50，木板*50，冰雕鱼*1，太阳鱼*1，石砖*50
STRINGS.RECIPE_DESC.WUXING_JITAN = "五行从此开始" -- 制作栏描述
AddRecipe2("wuxing_jitan",
    { Ingredient("goldnugget", 50), Ingredient("boards", 50), Ingredient(
        "oceanfish_medium_8_inv", 1), Ingredient("oceanfish_small_8_inv", 1), Ingredient("cutstone", 50) }, TECH.LOST,
    { atlas = "images/wuxing_jitan.xml", build_mode = BUILDMODE.LAND }, { "wuxing" })

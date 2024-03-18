local assets =
{
    Asset("ANIM", "anim/wuxing_jitan.zip"),
    Asset("ATLAS","images/wuxing_jitan.xml"),
	Asset("IMAGE","images/wuxing_jitan.tex"),	
}
STRINGS.NAMES.WUXING_JITAN = "五行祭坛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WUXING_JITAN = "获取五行之力"
local function onworkfinished(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end
require "prefabutil"
local assets =
{
    Asset("ANIM", "anim/wuxing_jitan.zip"),
    Asset("ATLAS", "images/wuxing_jitan.xml"),
    Asset("IMAGE", "images/wuxing_jitan.tex"),
}
STRINGS.NAMES.WUXING_JITAN = "五行祭坛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WUXING_JITAN = "获取五行之力"

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PushAnimation("idle", false)
end

local function onworkfinished(inst)
    TheNet:Announce("祭坛已建造")
end
local function onworked()

end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.Transform:SetScale(3, 3, 3)

    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, .8)

    inst.AnimState:SetBank("wuxing_jitan")
    inst.AnimState:SetBuild("wuxing_jitan")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()
    inst:AddTag("wuxing_jitan")
    if not TheWorld.ismastersim then
        return inst
    end
    -----------------------
    MakeHauntableLaunch(inst)

    inst:AddComponent("workable") --可以用锤子砸
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onworkfinished)
    inst.components.workable:SetOnWorkCallback(onworked)
    inst:ListenForEvent("onbuilt", onbuilt)

    -----------------------
    inst:AddComponent("lootdropper") -- 锤子砸掉掉落材料

    inst:AddComponent("inspectable")
    --------------------------------------------------------------------------------------
    -- inst:AddComponent("prototyper")
    -- inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.TERRA_ONE-------对应的科技树名字
    --------------------------------------------------------------------------------------

    return inst
end

return Prefab("wuxing_jitan", fn, assets),
    MakePlacer("wuxing_jitan_placer", "wuxing_jitan", "wuxing_jitan", "idle") -- 建造时候的虚影

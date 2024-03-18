local assets =
{
	Asset("ATLAS", "images/inventoryimages/lingzhu_jin.xml"),
	Asset("IMAGE", "images/inventoryimages/lingzhu_jin.tex"),
	Asset("ATLAS", "images/inventoryimages/lingzhu_mu.xml"),
	Asset("IMAGE", "images/inventoryimages/lingzhu_mu.tex"),
	Asset("ATLAS", "images/inventoryimages/lingzhu_shui.xml"),
	Asset("IMAGE", "images/inventoryimages/lingzhu_shui.tex"),
	Asset("ATLAS", "images/inventoryimages/lingzhu_huo.xml"),
	Asset("IMAGE", "images/inventoryimages/lingzhu_huo.tex"),
	Asset("ATLAS", "images/inventoryimages/lingzhu_tu.xml"),
	Asset("IMAGE", "images/inventoryimages/lingzhu_tu.tex"),
	Asset("ANIM", "anim/lingzhus.zip"),
}
local prefabs = {}
STRINGS.NAMES[string.upper("lingzhu")] = "灵珠"
STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper("lingzhu")] = "蕴含着天地五行之力"
local function onequip(inst, owner)
end

local function onunequip(inst, owner)
end


local function fn(lingzhuname)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:SetPristine()
	MakeInventoryPhysics(inst)
	inst.entity:AddMiniMapEntity()
	inst.AnimState:SetBank("lingzhus")--材质包
	inst.AnimState:SetBuild(lingzhuname)--动画集合
	inst.AnimState:PlayAnimation("idle")--动画
	inst.AddComponent()



	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.LINGZHU
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = lingzhuname
	inst.components.inventoryitem.atlasname = "images/inventoryimages/"..lingzhuname..".xml"



	return inst
end
prefabs={}
for k, v in ipairs({"lingzhu_jin","lingzhu_mu","lingzhu_shui","lingzhu_huo","lingzhu_tu"}) do
    table.insert(prefabs, Prefab(v, fn(v), assets))
end




return unpack(prefabs)

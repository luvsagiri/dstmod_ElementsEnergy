local function onequip(inst, owner)
	-- owner.AnimState:Show("ARM_carry")
	-- owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	-- owner.AnimState:Hide("ARM_carry")
	-- owner.AnimState:Show("ARM_normal")
end

local function makelingzhus(lingzhuname)
	local assets =
	{
		Asset("ATLAS", "images/inventoryimages/" .. lingzhuname .. ".xml"),
		Asset("IMAGE", "images/inventoryimages/" .. lingzhuname .. ".tex"),
		Asset("ANIM", "anim/lingzhus.zip"),
	}
	local function fn()
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()
		MakeInventoryPhysics(inst)                                --可拾取物的物理
		inst.AnimState:SetBank(lingzhuname)                       --动画集合
		inst.AnimState:SetBuild("lingzhus")                       --动画材质包
		inst.AnimState:PlayAnimation("idle", true)                --动画
		MakeInventoryFloatable(inst, "small", 0.05, { 1.2, 0.75, 1.2 }) --小型可飘浮物体
		inst.entity:SetPristine()
		if not TheWorld.ismastersim then
			return inst
		end
		-- 后面是主机才需要的
		-- inst.AddComponent()
		inst:AddComponent("inspectable")                                                       --可检查
		inst:AddComponent("inventoryitem")                                                     --可放入物品栏
		inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. lingzhuname .. ".xml" --物品栏里的贴图
		inst:AddComponent("equippable")                                                        --可装备
		inst.components.equippable.equipslot = EQUIPSLOTS.LINGZHU
		inst.components.equippable:SetOnEquip(onequip)
		inst.components.equippable:SetOnUnequip(onunequip)
		return inst
	end
	return Prefab(lingzhuname, fn, assets)
end

local lingzhuprefabs = {}
local lingzhunames = { "lingzhu_jin", "lingzhu_mu", "lingzhu_shui", "lingzhu_huo", "lingzhu_tu" }
for i, v in ipairs(lingzhunames) do
	table.insert(lingzhuprefabs, makelingzhus(v))
end
return unpack(lingzhuprefabs)

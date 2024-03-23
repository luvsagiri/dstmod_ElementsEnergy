GLOBAL["setmetatable"](env, {
    __index = function(t, k)
        return GLOBAL["rawget"](GLOBAL, k)
    end
})
GLOBAL.setmetatable(
    env,
    {
        __index = function(t, k)
            return GLOBAL.rawget(GLOBAL, k)
        end
    }
)
Assets = {
    Asset("ATLAS", "images/inventoryimages/lingzhu_inv.xml"),
    Asset("IMAGE", "images/inventoryimages/lingzhu_inv.tex"),
}

-- 泰拉借鉴能力勋章和五格装备栏，我超泰拉
if 1 then
    local Inv = require "widgets/inventorybar"
    local Widget = require "widgets/widget"

    if GLOBAL.EQUIPSLOTS then
        GLOBAL.EQUIPSLOTS["LINGZHU"] = "lingzhu"
    else
        GLOBAL.EQUIPSLOTS = {
            HANDS = "hands",
            HEAD = "head",
            BODY = "body",
            LINGZHU = "lingzhu",
        }
    end
    GLOBAL.EQUIPSLOT_IDS = {}
    local slot = 0
    for k, v in pairs(GLOBAL.EQUIPSLOTS) do
        slot = slot + 1
        GLOBAL.EQUIPSLOT_IDS[v] = slot
    end
    AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function(self)
        local W = 68
        local SEP = 12
        local INTERSEP = 28
        local Inv_Refresh_base = Inv.Refresh or function()
            return ""
        end
        local Inv_Rebuild_base = Inv.Rebuild or function()
            return ""
        end

        self.lingzhu_inv = self.root:AddChild(Widget("lingzhu_inv"))
        self.lingzhu_inv:SetScale(1.5, 1.5)

        local function getTotalW(self)
            local inventory = self.owner.replica.inventory
            local num_slots = inventory:GetNumSlots()
            local num_equip = #self.equipslotinfo
            local num_buttons = self.controller_build and 0 or 1
            local num_slotintersep = math.ceil(num_slots / 5)
            local num_equipintersep = num_buttons > 0 and 1 or 0
            local total_w = (num_slots + num_equip + num_buttons) * W +
                (num_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP +
                (num_slotintersep + num_equipintersep) * INTERSEP
            local x = (W - total_w) * .5 + num_slots * W + (num_slots - num_slotintersep) * SEP +
                num_slotintersep * INTERSEP
            return total_w, x
        end
        function Inv:LoadLingzhuSlots(self)
            self.bg:SetScale(1.3 + (slot - 4) * 0.05, 1, 1.25)--根据格子数量缩放装备栏
            self.bgcover:SetScale(1.3 + (slot - 4) * 0.05, 1, 1.25)
            -- if self.bg and self.bg.GetSize then
            --     local total_w, _ = getTotalW(self)
            --     local w, _ = self.bg:GetSize()
            --     self.bg:SetScale((total_w + W + SEP) / w, 1, 1) --根据格子数量缩放装备栏
            --     self.bgcover:SetScale((total_w + W + SEP) / w, 1, 1)
            -- end
            if self.addlingzhuslots == nil then
                self.addlingzhuslots = 1

                self:AddEquipSlot(GLOBAL.EQUIPSLOTS.LINGZHU, "images/inventoryimages/lingzhu_inv.xml", "lingzhu_inv.tex")

                if self.inspectcontrol then
                    local total_w, x = getTotalW(self)
                    self.inspectcontrol.icon:SetPosition(-6, 6)
                    self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, -6, 0)
                end
            end
        end

        function Inv:Refresh()
            Inv_Refresh_base(self)
            Inv:LoadLingzhuSlots(self)
        end

        function Inv:Rebuild()
            Inv_Rebuild_base(self)
            Inv:LoadLingzhuSlots(self)
            local inventory = self.owner.replica.inventory
            local overflow = inventory:GetOverflowContainer()
            overflow = (overflow ~= nil and overflow:IsOpenedBy(self.owner)) and overflow or nil
            local do_integrated_backpack = overflow ~= nil and self.integrated_backpack
        end
    end)
end

---------------------------------------------------------------------------------------------------
-- 预制物列表
PrefabFiles = {
    "lingzhus",
    "wuxing_jitan",
}
print(AllRecipes)
for k, v in ipairs(AllRecipes) do
    print(k, v.name)
end
modimport("scripts/strings.lua")
modimport("scripts/recipes.lua")

GLOBAL.setmetatable(
    env,
    {__index = function(t, k)
            return GLOBAL.rawget(GLOBAL, k)
        end}
)

--构建额外装备栏,直接抄泰拉
local Inv = require "widgets/inventorybar"
local Widget = require "widgets/widget"
if GLOBAL.EQUIPSLOTS then
    GLOBAL.EQUIPSLOTS["LINGZHU"]="lingzhu"
else
    GLOBAL.EQUIPSLOTS=
    {
        HANDS = "hands",
        HEAD = "head",
        BODY = "body",
        LINGZHU = "lingzhu",
    }
end
GLOBAL.EQUIPSLOT_IDS = {}
local slot = 0--装备栏格子数量
for k, v in pairs(GLOBAL.EQUIPSLOTS) do
    slot = slot + 1
    GLOBAL.EQUIPSLOT_IDS[v] = slot
end
-- slot = nil

AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function(self)
    local W = 68
    local SEP = 12
    local INTERSEP = 28
    local Inv_Refresh_base = Inv.Refresh or function() return "" end
    local Inv_Rebuild_base = Inv.Rebuild or function() return "" end
    
    self.lingzhu_inv=self.root:AddChild(Widget("lingzhu_inv"))
    self.lingzhu_inv:SetScale(1.5, 1.5)
    
    --获取total_w 即总宽度
    local function getTotalW(self)
        local inventory = self.owner.replica.inventory
        local num_slots = inventory:GetNumSlots() --物品槽数量
        local num_equip = #self.equipslotinfo --装备槽数量
        local num_buttons = self.controller_build and 0 or 1 --按钮数量
        local num_slotintersep = math.ceil(num_slots / 5) --物品槽间隔
        local num_equipintersep = num_buttons > 0 and 1 or 0 --装备间隔
        local total_w = (num_slots + num_equip + num_buttons) * W + (num_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP + (num_slotintersep + num_equipintersep) * INTERSEP
        local x=(W - total_w) * .5 + num_slots * W + (num_slots - num_slotintersep) * SEP + num_slotintersep * INTERSEP
        return total_w,x
    end

    --加载
    function Inv:LoadLingzhuSlots(self)
        self.bg:SetScale(1.3+(slot-4)*0.05,1,1.25)--根据格子数量缩放装备栏
        self.bgcover:SetScale(1.3+(slot-4)*0.05,1,1.25)

        if self.addspiritual_pearlslots == nil then
            self.addspiritual_pearlslots = 1

            self:AddEquipSlot(GLOBAL.EQUIPSLOTS.SPIRITUAL_PEARL, "images/inventoryimages/lingzhu_inv.xml","lingzhu_inv.tex")
                                                        
            if self.inspectcontrol then
                local total_w,x=getTotalW(self)
                self.inspectcontrol.icon:SetPosition(-6, 6)
                self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, -6, 0)
            end
        end
    end
    --刷新函数
    function Inv:Refresh()
        Inv_Refresh_base(self)
        Inv:LoadLingzhuSlots(self)
    end
    --构建函数
    function Inv:Rebuild()
        Inv_Rebuild_base(self)
        Inv:LoadLingzhuSlots(self)
        local inventory = self.owner.replica.inventory
        local overflow = inventory:GetOverflowContainer()
        overflow = (overflow ~= nil and overflow:IsOpenedBy(self.owner)) and overflow or nil
        local do_integrated_backpack = overflow ~= nil and self.integrated_backpack
    end
end)
---------------------------------------------------------------------------------------------------
local lingzhu = Class(function(self, inst)
    self.inst = inst --拥有该components的物体
    self.current_statu = nil
    self.unlocked_shuxings={}
    self.locked_shuxings={"jin","mu","shui","huo","tu"}
end)
local function setanime(self)
    if self.current_statu then
        self.inst.AnimState:SetBuild(self.current_statu)
        self.inst.AnimState:PlayAnimation("idle")
        self.inst.components.inventoryitem.imagename = "self.current_statu"
        self.inst.components.inventoryitem.atlasname = "images/inventoryimages/"..self.current_statu..".xml"
    end
end
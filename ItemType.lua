-- Modern clients moved GetItemInfo into C_Item; fall back for older clients.
local GetItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo;

local function OnTooltipSetItem(tooltip)
	if (tooltip ~= GameTooltip and tooltip ~= ItemRefTooltip) then
		return;
	end

	local _, link = tooltip:GetItem();
	if (link == nil) then
		return;
	end

	local _, _, _, _, _, sType, sSubType, itemStackCount = GetItemInfo(link);
	if (sType == nil) then
		-- Item info not cached yet; the tooltip will refresh once it is.
		return;
	end

	local stringL = ((sSubType and sSubType ~= "") and sType .. " | " .. sSubType or sType);
	local stringR = (itemStackCount and itemStackCount .. " per stack" or "");
	tooltip:AddLine(" ");
	tooltip:AddDoubleLine(stringL, stringR, 1, 0.82, 0, 1, 1, 1);
end

if (TooltipDataProcessor and Enum and Enum.TooltipDataType) then
	-- Modern tooltip system
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem);
else
	-- Legacy tooltip system
	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem);
	ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem);
end

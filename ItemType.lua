local ItemType = {};
ItemType.version = GetAddOnMetadata("ItemType", "Version");

-- ################################################################ --
-- ##                                                            ## --
-- ##  Startup Functions                                         ## --
-- ##                                                            ## --
-- ################################################################ --

function ItemType.OnEvent(_, event, arg1, arg2)
	if (event == "ADDON_LOADED" and arg1 == "ItemType") then		
		-- Rollover Item Tooltips
		ItemRefTooltip:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		--ItemRefShoppingTooltip3:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		-- Linked Item Tooltips
		GameTooltip:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		ShoppingTooltip1:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		ShoppingTooltip2:HookScript("OnTooltipSetItem", ItemType.AttachMain);
		--ShoppingTooltip3:HookScript("OnTooltipSetItem", ItemType.AttachMain);
	end
end

-- ################################################################ --
-- ##                                                            ## --
-- ##  Addon Core Functions                                      ## --
-- ##                                                            ## --
-- ################################################################ --

function ItemType.AttachMain(self)
	local _, link = self:GetItem();
	if (link ~= nil) then
		local _, _, _, _, _, sType, sSubType, itemStackCount = GetItemInfo(link);
		if (sSubType == nil) then
			self:AddDoubleLine(sType, itemStackCount, 1, 0.82, 0, 1, 1, 1);
		else
			self:AddDoubleLine(sType .. " | " ..sSubType, itemStackCount, 1, 0.82, 0, 1, 1, 1);
		end
		self:Show();
	end
end

-- ################################################################ --
-- ##                                                            ## --
-- ##  Last to load functions                                    ## --
-- ##                                                            ## --
-- ################################################################ --

ItemType.frame = CreateFrame("Frame", "ItemTypeFrame");
ItemType.frame:RegisterEvent("ADDON_LOADED");
ItemType.frame:SetScript("OnEvent", ItemType.OnEvent);
local E, L, V, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule('Skins')

--Cache global variables
--Lua functions
local _G = _G
local unpack = unpack

local function LoadSkin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.tradeskill ~= true then return end
	
	-- MainFrame
	TradeSkillFramePortrait:Kill()
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:CreateBackdrop("Default")
	TradeSkillFrame.RankFrame:SetStatusBarTexture(E["media"].normTex)
	E:RegisterStatusBar(TradeSkillFrame.RankFrame)
	TradeSkillFrame.FilterButton:StripTextures(true)
	TradeSkillFrame.FilterButton:CreateBackdrop('Default', true)
	TradeSkillFrame.FilterButton.backdrop:SetAllPoints()
	TradeSkillFrame.LinkToButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillFrame.LinkToButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillFrame.LinkToButton:GetHighlightTexture():Kill()
	TradeSkillFrame.LinkToButton:CreateBackdrop("Default")
	TradeSkillFrame.LinkToButton:Size(17, 14)
	TradeSkillFrame.LinkToButton:SetPoint("BOTTOMRIGHT", TradeSkillFrame.FilterButton, "TOPRIGHT", -2, 4)

	S:HandleEditBox(TradeSkillFrame.SearchBox)
	S:HandleCloseButton(TradeSkillFrameCloseButton)

	-- RecipeList
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.RecipeList.LearnedTab:StripTextures()
	TradeSkillFrame.RecipeList.UnlearnedTab:StripTextures()

	-- DetailsFrame
	TradeSkillFrame.DetailsFrame:StripTextures()
	TradeSkillFrame.DetailsInset:StripTextures()
	TradeSkillFrame.DetailsFrame.Background:Hide()
	S:HandleEditBox(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:DisableDrawLayer("BACKGROUND")

	S:HandleButton(TradeSkillFrame.DetailsFrame.CreateAllButton, true)
	S:HandleButton(TradeSkillFrame.DetailsFrame.CreateButton, true)
	S:HandleButton(TradeSkillFrame.DetailsFrame.ExitButton, true)

	--[[These cannot be skinned due to issues on Blizzards end.
	S:HandleScrollBar(TradeSkillFrame.RecipeList.scrollBar)
	S:HandleScrollBar(TradeSkillFrame.DetailsFrame.ScrollBar)]]

	S:HandleNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton, nil, true)
	S:HandleNextPrevButton(TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:Point("LEFT", TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, "RIGHT", 4, 0)

	hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshDisplay", function()
		local ResultIcon = TradeSkillFrame.DetailsFrame.Contents.ResultIcon
		ResultIcon:StyleButton()
		if ResultIcon:GetNormalTexture() then
			ResultIcon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			ResultIcon:GetNormalTexture():SetInside()
		end
		ResultIcon:SetTemplate("Default")
		ResultIcon.Background:SetTexture(nil)

		for i = 1, #TradeSkillFrame.DetailsFrame.Contents.Reagents do
			local Button = TradeSkillFrame.DetailsFrame.Contents.Reagents[i]
			local Icon = Button.Icon
			local Count = Button.Count
			
			Icon:SetTexCoord(unpack(E.TexCoords))
			Icon:SetDrawLayer("OVERLAY")
			if not Icon.backdrop then
				Icon.backdrop = CreateFrame("Frame", nil, Button)
				Icon.backdrop:SetFrameLevel(Button:GetFrameLevel() - 1)
				Icon.backdrop:SetTemplate("Default")
				Icon.backdrop:SetOutside(Icon)
			end
			
			Icon:SetParent(Icon.backdrop)
			Count:SetParent(Icon.backdrop)
			Count:SetDrawLayer("OVERLAY")
			
			Button.NameFrame:Kill()
		end
	end)

	--Guild Crafters
	-- TradeSkillGuildFrame:StripTextures()
	-- TradeSkillGuildFrame:SetTemplate("Transparent")
	-- TradeSkillGuildFrame:Point("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 3, 19)
	-- TradeSkillGuildFrameContainer:StripTextures()
	-- TradeSkillGuildFrameContainer:SetTemplate("Default")
	-- S:HandleCloseButton(TradeSkillGuildFrameCloseButton)
end

S:RegisterSkin("Blizzard_TradeSkillUI", LoadSkin)
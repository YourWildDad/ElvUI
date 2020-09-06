local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local DB = E:GetModule('DataBars')

local _G = _G
local format = format
local IsPlayerAtEffectiveMaxLevel = IsPlayerAtEffectiveMaxLevel
local C_Reputation_GetFactionParagonInfo = C_Reputation.GetFactionParagonInfo
local C_Reputation_IsFactionParagon = C_Reputation.IsFactionParagon
local GetFriendshipReputation = GetFriendshipReputation
local GetWatchedFactionInfo = GetWatchedFactionInfo
local ToggleCharacter = ToggleCharacter
local REPUTATION = REPUTATION
local STANDING = STANDING

function DB:ReputationBar_Update()
	local bar = DB.StatusBars.Reputation
	local name, reaction, Min, Max, value, factionID = GetWatchedFactionInfo()

	if not name or (DB.db.reputation.hideBelowMaxLevel and not IsPlayerAtEffectiveMaxLevel()) then
		bar:Hide()
		return
	end

	local friendshipID = GetFriendshipReputation(factionID)
	local textFormat, text = DB.db.reputation.textFormat, ''
	local isCapped, isFriend, friendText, standingLabel

	if friendshipID then
		local _, friendRep, _, _, _, _, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
		isFriend, reaction, friendText = true, 5, friendTextLevel
		if nextFriendThreshold then
			Min, Max, value = friendThreshold, nextFriendThreshold, friendRep;
		else
			Min, Max, value = 0, 1, 1
			isCapped = true
		end
	elseif C_Reputation_IsFactionParagon(factionID) then
		local currentValue, threshold, _, hasRewardPending = C_Reputation_GetFactionParagonInfo(factionID)
		if currentValue and threshold then
			Min, Max = 0, threshold
			value = currentValue % threshold
			if hasRewardPending then
				value = value + threshold
			end
		end
	elseif reaction == _G.MAX_REPUTATION_REACTION then
		Min, Max, value = 0, 1, 1
		isCapped = true
	end

	bar:SetMinMaxValues(Min, Max)
	bar:SetValue(value)
	local color = _G.FACTION_BAR_COLORS[reaction]
	bar:SetStatusBarColor(color.r, color.g, color.b)

	standingLabel = _G['FACTION_STANDING_LABEL'..reaction]

	--Prevent a division by zero
	local maxMinDiff = Max - Min
	if maxMinDiff == 0 then
		maxMinDiff = 1
	end

	if isCapped and textFormat ~= 'NONE' then
		-- show only name and standing on exalted
		text = format('%s: [%s]', name, isFriend and friendText or standingLabel)
	else
		if textFormat == 'PERCENT' then
			text = format('%s: %d%% [%s]', name, ((value - Min) / (maxMinDiff) * 100), isFriend and friendText or standingLabel)
		elseif textFormat == 'CURMAX' then
			text = format('%s: %s - %s [%s]', name, E:ShortValue(value - Min), E:ShortValue(Max - Min), isFriend and friendText or standingLabel)
		elseif textFormat == 'CURPERC' then
			text = format('%s: %s - %d%% [%s]', name, E:ShortValue(value - Min), ((value - Min) / (maxMinDiff) * 100), isFriend and friendText or standingLabel)
		elseif textFormat == 'CUR' then
			text = format('%s: %s [%s]', name, E:ShortValue(value - Min), isFriend and friendText or standingLabel)
		elseif textFormat == 'REM' then
			text = format('%s: %s [%s]', name, E:ShortValue((Max - Min) - (value-Min)), isFriend and friendText or standingLabel)
		elseif textFormat == 'CURREM' then
			text = format('%s: %s - %s [%s]', name, E:ShortValue(value - Min), E:ShortValue((Max - Min) - (value-Min)), isFriend and friendText or standingLabel)
		elseif textFormat == 'CURPERCREM' then
			text = format('%s: %s - %d%% (%s) [%s]', name, E:ShortValue(value - Min), ((value - Min) / (maxMinDiff) * 100), E:ShortValue((Max - Min) - (value-Min)), isFriend and friendText or standingLabel)
		end
	end

	if textFormat ~= 'NONE' then
		bar.text:SetText(text)
	end

	bar:Show()
end

function DB:ReputationBar_OnEnter()
	if self.db.mouseover then
		E:UIFrameFadeIn(self, 0.4, self:GetAlpha(), 1)
	end

	local name, reaction, min, max, value, factionID = GetWatchedFactionInfo()
	if factionID and C_Reputation_IsFactionParagon(factionID) then
		local currentValue, threshold, _, hasRewardPending = C_Reputation_GetFactionParagonInfo(factionID)
		if currentValue and threshold then
			min, max = 0, threshold
			value = currentValue % threshold
			if hasRewardPending then
				value = value + threshold
			end
		end
	end

	if name then
		_G.GameTooltip:ClearLines()
		_G.GameTooltip:SetOwner(self, 'ANCHOR_CURSOR', 0, -4)
		_G.GameTooltip:AddLine(name)
		_G.GameTooltip:AddLine(' ')

		local friendID, friendTextLevel, _
		if factionID then friendID, _, _, _, _, _, friendTextLevel = GetFriendshipReputation(factionID) end

		_G.GameTooltip:AddDoubleLine(STANDING..':', (friendID and friendTextLevel) or _G['FACTION_STANDING_LABEL'..reaction], 1, 1, 1)
		if reaction ~= _G.MAX_REPUTATION_REACTION or C_Reputation_IsFactionParagon(factionID) then
			_G.GameTooltip:AddDoubleLine(REPUTATION..':', format('%d / %d (%d%%)', value - min, max - min, (value - min) / ((max - min == 0) and max or (max - min)) * 100), 1, 1, 1)
		end
		_G.GameTooltip:Show()
	end
end

function DB:ReputationBar_OnClick()
	ToggleCharacter('ReputationFrame')
end

function DB:ReputationBar_Toggle()
	local bar = DB.StatusBars.Reputation

	bar:SetShown(bar.db.enable)
	if bar.db.enable then
		DB:RegisterEvent('UPDATE_FACTION', 'ReputationBar_Update')
		DB:RegisterEvent('COMBAT_TEXT_UPDATE', 'ReputationBar_Update')
		DB:ReputationBar_Update()
		E:EnableMover(bar.mover:GetName())
	else
		DB:UnregisterEvent('UPDATE_FACTION')
		DB:UnregisterEvent('COMBAT_TEXT_UPDATE')
		E:DisableMover(bar.mover:GetName())
	end
end

function DB:ReputationBar()
	DB.StatusBars.Reputation = DB:CreateBar('ElvUI_ReputationBar', DB.ReputationBar_OnEnter, DB.ReputationBar_OnClick, 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -3, -264)
	DB.StatusBars.Reputation.db = DB.db.reputation

	E:CreateMover(DB.StatusBars.Reputation, 'ReputationBarMover', L["Reputation Bar"], nil, nil, nil, nil, nil, 'databars,reputation')
	DB:ReputationBar_Toggle()
end

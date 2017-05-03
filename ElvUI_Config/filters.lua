local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local UF = E:GetModule('UnitFrames');

local selectedSpell;
local selectedFilter;
local filters;
local tinsert = table.insert
local tonumber = tonumber
local format = string.format
local UNKNOWN = UNKNOWN

local function UpdateFilterGroup()
	--Prevent errors when choosing a new filter, by doing a reset of the groups
	E.Options.args.filters.args.filterGroup = nil
	E.Options.args.filters.args.spellGroup = nil

	if selectedFilter == 'Debuff Highlight' then
		if not selectedFilter then
			E.Options.args.filters.args.filterGroup = nil
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = 10,
			args = {
				addSpell = {
					order = 1,
					name = L["Add Spell ID or Name"],
					desc = L["Add a spell to the filter. Use spell ID if you don't want to match all auras which share the same name."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then value = tonumber(value) end
						E.global.unitframe.DebuffHighlightColors[value] = {enable = true, style = 'GLOW', color = {r = 0.8, g = 0, b = 0, a = 0.85}}
						UpdateFilterGroup();
						UF:Update_AllFrames();
					end,
				},
				removeSpell = {
					order = 1,
					name = L["Remove Spell ID or Name"],
					desc = L["Remove a spell from the filter. Use the spell ID if you see the ID as part of the spell name in the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then value = tonumber(value) end
						E.global.unitframe.DebuffHighlightColors[value] = nil;
						selectedSpell = nil;
						UpdateFilterGroup();
						UF:Update_AllFrames();
					end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = 'select',
					order = -9,
					guiInline = true,
					get = function(info) return selectedSpell end,
					set = function(info, value) selectedSpell = value; UpdateFilterGroup() end,
					values = function()
						local filters = {}
						filters[''] = NONE
						for filter in pairs(E.global.unitframe.DebuffHighlightColors) do
							local spellString
							if tonumber(filter) then
								local spellName = GetSpellInfo(filter)
								if spellName then
									filter = format("%s (%s)", spellName, filter)
								else
									filter = tostring(filter)
								end
							end
							filters[filter] = filter
						end

						return filters
					end,
				},
			},
		}
		
		local spellID = selectedSpell and string.match(selectedSpell, "(%d+)")
		if spellID then spellID = tonumber(spellID) end

		if not selectedSpell or E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)] == nil then
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.spellGroup = {
			type = "group",
			name = selectedSpell,
			order = 15,
			guiInline = true,
			args = {
				enabled = {
					name = L["Enable"],
					order = 0,
					type = 'toggle',
					get = function(info)
						return E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].enable
					end,
					set = function(info, value)
						E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].enable = value
						UF:Update_AllFrames();
					end,
				},
				style = {
					name = L["Style"],
					type = 'select',
					order = 3,
					values = {
						['GLOW'] = L["Glow"],
						['FILL'] = L["Fill"]
					},
					get = function(info)
						return E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].style
					end,
					set = function(info, value)
						E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].style = value
						UF:Update_AllFrames();
					end,
				},
				color = {
					name = L["Color"],
					type = 'color',
					order = 1,
					hasAlpha = true,
					get = function(info)
						local t = E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].color
						return t.r, t.g, t.b, t.a
					end,
					set = function(info, r, g, b, a)
						local t = E.global.unitframe.DebuffHighlightColors[(spellID or selectedSpell)].color
						t.r, t.g, t.b, t.a = r, g, b, a
						UF:Update_AllFrames();
					end,
				},
			},
		}
	elseif selectedFilter == 'AuraBar Colors' then
		if not selectedFilter then
			E.Options.args.filters.args.filterGroup = nil
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = 10,
			args = {
				addSpell = {
					order = 1,
					name = L["Add Spell ID or Name"],
					desc = L["Add a spell to the filter. Use spell ID if you don't want to match all auras which share the same name."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then value = tonumber(value) end
						if not E.global.unitframe.AuraBarColors[value] then
							E.global.unitframe.AuraBarColors[value] = false
						end
						UpdateFilterGroup();
						UF:CreateAndUpdateUF('player')
						UF:CreateAndUpdateUF('target')
						UF:CreateAndUpdateUF('focus')
					end,
				},
				removeSpell = {
					order = 1,
					name = L["Remove Spell ID or Name"],
					desc = L["Remove a spell from the filter. Use the spell ID if you see the ID as part of the spell name in the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then value = tonumber(value) end
						if G['unitframe'].AuraBarColors[value] then
							E.global.unitframe.AuraBarColors[value] = false;
							E:Print(L["You may not remove a spell from a default filter that is not customly added. Setting spell to false instead."])
						else
							E.global.unitframe.AuraBarColors[value] = nil;
						end
						selectedSpell = nil;
						UpdateFilterGroup();
						UF:CreateAndUpdateUF('player')
						UF:CreateAndUpdateUF('target')
						UF:CreateAndUpdateUF('focus')
					end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = 'select',
					order = -9,
					guiInline = true,
					get = function(info) return selectedSpell end,
					set = function(info, value)
						selectedSpell = value;
						UpdateFilterGroup()
					end,
					values = function()
						local filters = {}
						filters[''] = NONE
						for filter in pairs(E.global.unitframe.AuraBarColors) do
							local spellString
							if tonumber(filter) then
								local spellName = GetSpellInfo(filter)
								if spellName then
									filter = format("%s (%s)", spellName, filter)
								else
									filter = tostring(filter)
								end
							end
							filters[filter] = filter
						end

						return filters
					end,
				},
			},
		}

		local spellID = selectedSpell and string.match(selectedSpell, "(%d+)")
		if spellID then spellID = tonumber(spellID) end

		if not selectedSpell or E.global.unitframe.AuraBarColors[(spellID or selectedSpell)] == nil then
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.spellGroup = {
			type = "group",
			name = selectedSpell,
			order = 15,
			guiInline = true,
			args = {
				color = {
					name = L["Color"],
					type = 'color',
					order = 1,
					get = function(info)
						local t = E.global.unitframe.AuraBarColors[(spellID or selectedSpell)]
						if type(t) == 'boolean' then
							return 0, 0, 0, 1
						else
							return t.r, t.g, t.b, t.a
						end
					end,
					set = function(info, r, g, b)
						local spell = (spellID or selectedSpell)
						if type(E.global.unitframe.AuraBarColors[spell]) ~= 'table' then
							E.global.unitframe.AuraBarColors[spell] = {}
						end
						local t = E.global.unitframe.AuraBarColors[spell]
						t.r, t.g, t.b = r, g, b
						UF:CreateAndUpdateUF('player')
						UF:CreateAndUpdateUF('target')
						UF:CreateAndUpdateUF('focus')
					end,
				},
				removeColor = {
					type = 'execute',
					order = 2,
					name = L["Restore Defaults"],
					func = function(info, value)
						E.global.unitframe.AuraBarColors[(spellID or selectedSpell)] = false;
						UF:CreateAndUpdateUF('player')
						UF:CreateAndUpdateUF('target')
						UF:CreateAndUpdateUF('focus')
					end,
				},
			},
		}
	elseif selectedFilter == 'Buff Indicator (Pet)' then
		if not E.global.unitframe.buffwatch.PET then
			E.global.unitframe.buffwatch.PET = {};
		end

		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = -10,
			childGroups = "select",
			args = {
				addSpellID = {
					order = 1,
					name = L["Add SpellID"],
					desc = L["Add a spell to the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							E.global.unitframe.buffwatch.PET[tonumber(value)] = {["enabled"] = true, ["id"] = tonumber(value), ["point"] = "TOPRIGHT", ["color"] = {["r"] = 1, ["g"] = 0, ["b"] = 0}, ["anyUnit"] = true, ['style'] = 'coloredIcon', ["xOffset"] = 0, ["yOffset"] = 0}
							selectedSpell = nil;
							UpdateFilterGroup();
							UF:CreateAndUpdateUF('pet');
						end
					end,
				},
				removeSpellID = {
					order = 2,
					name = L["Remove SpellID"],
					desc = L["Remove a spell from the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							local spellID = tonumber(value)
							if G.unitframe.buffwatch.PET[spellID] then
								E.global.unitframe.buffwatch.PET[spellID].enabled = false
								E:Print(L["You may not remove a spell from a default filter that is not customly added. Setting spell to false instead."])
							else
								E.global.unitframe.buffwatch.PET[spellID] = nil
							end
						end

						selectedSpell = nil;
						UpdateFilterGroup();
						UF:CreateAndUpdateUF('pet')
					end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = "select",
					order = 3,
					values = function()
						local values = {};

						for _, spell in pairs(E.global.unitframe.buffwatch.PET) do
							if spell.id then
								local name = GetSpellInfo(spell.id)
								values[spell.id] = name;
							end
						end
						return values
					end,
					get = function(info) return selectedSpell end,
					set = function(info, value)
						selectedSpell = value;
						UpdateFilterGroup()
					end,
				},
			},
		}
		if selectedSpell then
			local name = GetSpellInfo(selectedSpell)
			E.Options.args.filters.args.filterGroup.args[name] = {
				name = name..' ('..selectedSpell..')',
				type = 'group',
				get = function(info) return E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ] end,
				set = function(info, value) E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ] = value; UF:CreateAndUpdateUF('pet') end,
				order = -10,
				args = {
					enabled = {
						name = L["Enable"],
						order = 0,
						type = 'toggle',
					},
					point = {
						name = L["Anchor Point"],
						order = 1,
						type = 'select',
						values = {
							['TOPLEFT'] = 'TOPLEFT',
							['TOPRIGHT'] = 'TOPRIGHT',
							['BOTTOMLEFT'] = 'BOTTOMLEFT',
							['BOTTOMRIGHT'] = 'BOTTOMRIGHT',
							['LEFT'] = 'LEFT',
							['RIGHT'] = 'RIGHT',
							['TOP'] = 'TOP',
							['BOTTOM'] = 'BOTTOM',
						}
					},
					sizeOverride = {
						order = 2,
						type = "range",
						name = L["Size Override"],
						min = 0, max = 50, step = 1,
					},
					xOffset = {
						order = 3,
						type = 'range',
						name = L["xOffset"],
						min = -75, max = 75, step = 1,
					},
					yOffset = {
						order = 4,
						type = 'range',
						name = L["yOffset"],
						min = -75, max = 75, step = 1,
					},
					style = {
						name = L["Style"],
						order = 5,
						type = 'select',
						values = {
							['coloredIcon'] = L["Colored Icon"],
							['texturedIcon'] = L["Textured Icon"],
							['NONE'] = NONE,
						},
					},
					color = {
						name = L["Color"],
						type = 'color',
						order = 6,
						get = function(info)
							local t = E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ]
							return t.r, t.g, t.b, t.a
						end,
						set = function(info, r, g, b)
							local t = E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:CreateAndUpdateUF('pet')
						end,
					},
					displayText = {
						name = L["Display Text"],
						type = 'toggle',
						order = 7,
					},
					textColor = {
						name = L["Text Color"],
						type = 'color',
						order = 8,
						get = function(info)
							local t = E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ]
							if t then
								return t.r, t.g, t.b, t.a
							else
								return 1, 1, 1, 1
							end
						end,
						set = function(info, r, g, b)
							local t = E.global.unitframe.buffwatch.PET[selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:CreateAndUpdateUF('pet')
						end,
					},
					decimalThreshold = {
						name = L["Decimal Threshold"],
						desc = L["Threshold before text goes into decimal form. Set to -1 to disable decimals."],
						type = 'range',
						order = 9,
						min = -1, max = 10, step = 1,
					},
					textThreshold = {
						name = L["Text Threshold"],
						desc = L["At what point should the text be displayed. Set to -1 to disable."],
						type = 'range',
						order = 10,
						min = -1, max = 60, step = 1,
					},
					anyUnit = {
						name = L["Show Aura From Other Players"],
						order = 11,
						type = 'toggle',
					},
					onlyShowMissing = {
						name = L["Show When Not Active"],
						order = 12,
						type = 'toggle',
					},
				},
			}
		end
	elseif selectedFilter == 'Buff Indicator' then
		if not E.global.unitframe.buffwatch[E.myclass] then E.global.unitframe.buffwatch[E.myclass] = {} end

		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = -10,
			childGroups = "select",
			args = {
				addSpellID = {
					order = 1,
					name = L["Add SpellID"],
					desc = L["Add a spell to the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							E.global.unitframe.buffwatch[E.myclass][tonumber(value)] = {["enabled"] = true, ["id"] = tonumber(value), ["point"] = "TOPRIGHT", ["color"] = {["r"] = 1, ["g"] = 0, ["b"] = 0}, ["anyUnit"] = false, ['style'] = 'coloredIcon', ["xOffset"] = 0, ["yOffset"] = 0}
							selectedSpell = nil;
							UpdateFilterGroup();

							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
							UF:UpdateAuraWatchFromHeader('raidpet', true)
						end
					end,
				},
				removeSpellID = {
					order = 2,
					name = L["Remove SpellID"],
					desc = L["Remove a spell from the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							local spellID = tonumber(value)
							if G.unitframe.buffwatch[E.myclass][spellID] then
								E.global.unitframe.buffwatch[E.myclass][spellID].enabled = false
								E:Print(L["You may not remove a spell from a default filter that is not customly added. Setting spell to false instead."])
							else
								E.global.unitframe.buffwatch[E.myclass][spellID] = nil
							end
						end

						selectedSpell = nil;
						UpdateFilterGroup();
						UF:UpdateAuraWatchFromHeader('raid')
						UF:UpdateAuraWatchFromHeader('raid40')
						UF:UpdateAuraWatchFromHeader('party')
						UF:UpdateAuraWatchFromHeader('raidpet', true)
					end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = "select",
					order = 3,
					values = function()
						local values = {};
						for _, spell in pairs(E.global.unitframe.buffwatch[E.myclass]) do
							if spell.id then
								local name = GetSpellInfo(spell.id)
								values[spell.id] = name;
							end
						end
						return values
					end,
					get = function(info) return selectedSpell end,
					set = function(info, value)
						selectedSpell = value;
						UpdateFilterGroup()
					end,
				},
			},
		}

		if selectedSpell then
			local name = GetSpellInfo(selectedSpell)
			E.Options.args.filters.args.filterGroup.args[name] = {
				name = name..' ('..selectedSpell..')',
				type = 'group',
				get = function(info) return E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ] end,
				set = function(info, value)
					E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ] = value;

					UF:UpdateAuraWatchFromHeader('raid')
					UF:UpdateAuraWatchFromHeader('raid40')
					UF:UpdateAuraWatchFromHeader('party')
					UF:UpdateAuraWatchFromHeader('raidpet', true)
				end,
				order = -10,
				args = {
					enabled = {
						name = L["Enable"],
						order = 0,
						type = 'toggle',
					},
					point = {
						name = L["Anchor Point"],
						order = 1,
						type = 'select',
						values = {
							['TOPLEFT'] = 'TOPLEFT',
							['TOPRIGHT'] = 'TOPRIGHT',
							['BOTTOMLEFT'] = 'BOTTOMLEFT',
							['BOTTOMRIGHT'] = 'BOTTOMRIGHT',
							['LEFT'] = 'LEFT',
							['RIGHT'] = 'RIGHT',
							['TOP'] = 'TOP',
							['BOTTOM'] = 'BOTTOM',
						}
					},
					sizeOverride = {
						order = 2,
						type = "range",
						name = L["Size Override"],
						min = 0, max = 50, step = 1,
					},
					xOffset = {
						order = 3,
						type = 'range',
						name = L["xOffset"],
						min = -75, max = 75, step = 1,
					},
					yOffset = {
						order = 4,
						type = 'range',
						name = L["yOffset"],
						min = -75, max = 75, step = 1,
					},
					style = {
						name = L["Style"],
						order = 5,
						type = 'select',
						values = {
							['coloredIcon'] = L["Colored Icon"],
							['texturedIcon'] = L["Textured Icon"],
							['NONE'] = NONE,
						},
					},
					color = {
						name = L["Color"],
						type = 'color',
						order = 6,
						get = function(info)
							local t = E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ]
							return t.r, t.g, t.b, t.a
						end,
						set = function(info, r, g, b)
							local t = E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
							UF:UpdateAuraWatchFromHeader('raidpet', true)
						end,
					},
					displayText = {
						name = L["Display Text"],
						type = 'toggle',
						order = 7,
					},
					textColor = {
						name = L["Text Color"],
						type = 'color',
						order = 8,
						get = function(info)
							local t = E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ]
							if t then
								return t.r, t.g, t.b, t.a
							else
								return 1, 1, 1, 1
							end
						end,
						set = function(info, r, g, b)
							local t = E.global.unitframe.buffwatch[E.myclass][selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
							UF:UpdateAuraWatchFromHeader('raidpet', true)
						end,
					},
					decimalThreshold = {
						name = L["Decimal Threshold"],
						desc = L["Threshold before text goes into decimal form. Set to -1 to disable decimals."],
						type = 'range',
						order = 9,
						min = -1, max = 10, step = 1,
					},
					textThreshold = {
						name = L["Text Threshold"],
						desc = L["At what point should the text be displayed. Set to -1 to disable."],
						type = 'range',
						order = 10,
						min = -1, max = 60, step = 1,
					},
					anyUnit = {
						name = L["Show Aura From Other Players"],
						order = 11,
						type = 'toggle',
					},
					onlyShowMissing = {
						name = L["Show When Not Active"],
						order = 12,
						type = 'toggle',
					},
				},
			}
		end
	elseif selectedFilter == 'Buff Indicator (Profile)' then
		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = -10,
			childGroups = "select",
			args = {
				addSpellID = {
					order = 1,
					name = L["Add SpellID"],
					desc = L["Add a spell to the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							E.db.unitframe.filters.buffwatch[tonumber(value)] = {["enabled"] = true, ["id"] = tonumber(value), ["point"] = "TOPRIGHT", ["color"] = {["r"] = 1, ["g"] = 0, ["b"] = 0}, ["anyUnit"] = false, ['style'] = 'coloredIcon', ["xOffset"] = 0, ["yOffset"] = 0}
							selectedSpell = nil;
							UpdateFilterGroup();

							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
						end
					end,
				},
				removeSpellID = {
					order = 2,
					name = L["Remove SpellID"],
					desc = L["Remove a spell from the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if not tonumber(value) then
							E:Print(L["Value must be a number"])
						elseif not GetSpellInfo(value) then
							E:Print(L["Not valid spell id"])
						else
							local spellID = tonumber(value)
							if P.unitframe.filters.buffwatch[spellID] then
								E.db.unitframe.filters.buffwatch[spellID].enabled = false
								E:Print(L["You may not remove a spell from a default filter that is not customly added. Setting spell to false instead."])
							else
								E.db.unitframe.filters.buffwatch[spellID] = nil
							end
						end

						selectedSpell = nil;
						UpdateFilterGroup();
						UF:UpdateAuraWatchFromHeader('raid')
						UF:UpdateAuraWatchFromHeader('raid40')
						UF:UpdateAuraWatchFromHeader('party')
					end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = "select",
					order = 3,
					values = function()
						local values = {};
						for _, spell in pairs(E.db.unitframe.filters.buffwatch) do
							if spell.id then
								local name = GetSpellInfo(spell.id)
								values[spell.id] = name;
							end
						end
						return values
					end,
					get = function(info) return selectedSpell end,
					set = function(info, value)
						selectedSpell = value;
						UpdateFilterGroup()
					end,
				},
			},
		}

		if selectedSpell then
			local name = GetSpellInfo(selectedSpell)
			E.Options.args.filters.args.filterGroup.args[name] = {
				name = name..' ('..selectedSpell..')',
				type = 'group',
				hidden = function() return not E.db.unitframe.filters.buffwatch[selectedSpell] end,
				get = function(info)
					if E.db.unitframe.filters.buffwatch[selectedSpell] then
						return E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ]
					end
				end,
				set = function(info, value)
					E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ] = value;

					UF:UpdateAuraWatchFromHeader('raid')
					UF:UpdateAuraWatchFromHeader('raid40')
					UF:UpdateAuraWatchFromHeader('party')
				end,
				order = -10,
				args = {
					enabled = {
						name = L["Enable"],
						order = 0,
						type = 'toggle',
					},
					point = {
						name = L["Anchor Point"],
						order = 1,
						type = 'select',
						values = {
							['TOPLEFT'] = 'TOPLEFT',
							['TOPRIGHT'] = 'TOPRIGHT',
							['BOTTOMLEFT'] = 'BOTTOMLEFT',
							['BOTTOMRIGHT'] = 'BOTTOMRIGHT',
							['LEFT'] = 'LEFT',
							['RIGHT'] = 'RIGHT',
							['TOP'] = 'TOP',
							['BOTTOM'] = 'BOTTOM',
						}
					},
					sizeOverride = {
						order = 2,
						type = "range",
						name = L["Size Override"],
						min = 0, max = 50, step = 1,
					},
					xOffset = {
						order = 3,
						type = 'range',
						name = L["xOffset"],
						min = -75, max = 75, step = 1,
					},
					yOffset = {
						order = 4,
						type = 'range',
						name = L["yOffset"],
						min = -75, max = 75, step = 1,
					},
					style = {
						name = L["Style"],
						order = 5,
						type = 'select',
						values = {
							['coloredIcon'] = L["Colored Icon"],
							['texturedIcon'] = L["Textured Icon"],
							['NONE'] = NONE,
						},
					},
					color = {
						name = L["Color"],
						type = 'color',
						order = 6,
						get = function(info)
							if E.db.unitframe.filters.buffwatch[selectedSpell] then
								local t = E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ]
								return t.r, t.g, t.b, t.a
							end
						end,
						set = function(info, r, g, b)
							local t = E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
						end,
					},
					displayText = {
						name = L["Display Text"],
						type = 'toggle',
						order = 7,
					},
					textColor = {
						name = L["Text Color"],
						type = 'color',
						order = 8,
						get = function(info)
							if E.db.unitframe.filters.buffwatch[selectedSpell] then
								local t = E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ]
								if t then
									return t.r, t.g, t.b, t.a
								else
									return 1, 1, 1, 1
								end
							end
						end,
						set = function(info, r, g, b)
							local t = E.db.unitframe.filters.buffwatch[selectedSpell][ info[#info] ]
							t.r, t.g, t.b = r, g, b
							UF:UpdateAuraWatchFromHeader('raid')
							UF:UpdateAuraWatchFromHeader('raid40')
							UF:UpdateAuraWatchFromHeader('party')
						end,
					},
					decimalThreshold = {
						name = L["Decimal Threshold"],
						desc = L["Threshold before text goes into decimal form. Set to -1 to disable decimals."],
						type = 'range',
						order = 9,
						min = -1, max = 10, step = 1,
					},
					textThreshold = {
						name = L["Text Threshold"],
						desc = L["At what point should the text be displayed. Set to -1 to disable."],
						type = 'range',
						order = 10,
						min = -1, max = 60, step = 1,
					},
					anyUnit = {
						name = L["Show Aura From Other Players"],
						order = 11,
						type = 'toggle',
					},
					onlyShowMissing = {
						name = L["Show When Not Active"],
						order = 12,
						type = 'toggle',
					},
				},
			}
		end
	else
		if not selectedFilter or not E.global.unitframe['aurafilters'][selectedFilter] then
			E.Options.args.filters.args.filterGroup = nil
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.filterGroup = {
			type = 'group',
			name = selectedFilter,
			guiInline = true,
			order = 10,
			args = {
				addSpell = {
					order = 1,
					name = L["Add Spell ID or Name"],
					desc = L["Add a spell to the filter. Use spell ID if you don't want to match all auras which share the same name."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then	value = tonumber(value) end
						if not E.global.unitframe['aurafilters'][selectedFilter]['spells'][value] then
							E.global.unitframe['aurafilters'][selectedFilter]['spells'][value] = {
								['enable'] = true,
								['priority'] = 0,
							}
						end
						UpdateFilterGroup();
						UF:Update_AllFrames();
					end,
				},
				removeSpell = {
					order = 1,
					name = L["Remove Spell ID or Name"],
					desc = L["Remove a spell from the filter. Use the spell ID if you see the ID as part of the spell name in the filter."],
					type = 'input',
					get = function(info) return "" end,
					set = function(info, value)
						if tonumber(value) then value = tonumber(value) end
						if G['unitframe']['aurafilters'][selectedFilter] then
							if G['unitframe']['aurafilters'][selectedFilter]['spells'][value] then
								E.global.unitframe['aurafilters'][selectedFilter]['spells'][value].enable = false;
								E:Print(L["You may not remove a spell from a default filter that is not customly added. Setting spell to false instead."])
							else
								E.global.unitframe['aurafilters'][selectedFilter]['spells'][value] = nil;
							end
						else
							E.global.unitframe['aurafilters'][selectedFilter]['spells'][value] = nil;
						end

						UpdateFilterGroup();
						UF:Update_AllFrames();
					end,
				},
				filterType = {
					order = 4,
					name = L["Filter Type"],
					desc = L["Set the filter type. Blacklist will hide any auras in the list and show all others. Whitelist will show any auras in the filter and hide all others."],
					type = 'select',
					values = {
						['Whitelist'] = L["Whitelist"],
						['Blacklist'] = L["Blacklist"],
					},
					get = function() return E.global.unitframe['aurafilters'][selectedFilter].type end,
					set = function(info, value) E.global.unitframe['aurafilters'][selectedFilter].type = value; UF:Update_AllFrames(); end,
				},
				selectSpell = {
					name = L["Select Spell"],
					type = 'select',
					order = -9,
					guiInline = true,
					get = function(info) return selectedSpell end,
					set = function(info, value)
						selectedSpell = value;
						UpdateFilterGroup()
					end,
					values = function()
						local filters = {}
						filters[''] = NONE
						for filter in pairs(E.global.unitframe['aurafilters'][selectedFilter]['spells']) do
							local spellString
							if tonumber(filter) then
								local spellName = GetSpellInfo(filter)
								if spellName then
									filter = format("%s (%s)", spellName, filter)
								else
									filter = tostring(filter)
								end
							end
							filters[filter] = filter
						end

						return filters
					end,
				},
			},
		}

		local spellID = selectedSpell and string.match(selectedSpell, "(%d+)")
		if spellID then spellID = tonumber(spellID) end

		if not selectedSpell or not E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)] then
			E.Options.args.filters.args.spellGroup = nil
			return
		end

		E.Options.args.filters.args.spellGroup = {
			type = "group",
			name = selectedSpell,
			order = 15,
			guiInline = true,
			args = {
				enable = {
					name = L["Enable"],
					type = "toggle",
					get = function()
						if selectedFolder or not (spellID or selectedSpell) then
							return false
						else
							return E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].enable
						end
					end,
					set = function(info, value) E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].enable = value; UpdateFilterGroup(); UF:Update_AllFrames(); end
				},
			},
		}

		if selectedFilter == "RaidDebuffs" or selectedFilter == "CCDebuffs" then
			E.Options.args.filters.args.spellGroup.args.priority = {
				name = L["Priority"],
				type = "range",
				get = function()
					if selectedFolder or not selectedSpell then
						return 0
					else
						return E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].priority
					end
				end,
				set = function(info, value) E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].priority = value; UpdateFilterGroup(); UF:Update_AllFrames(); end,
				min = 0, max = 99, step = 1,
				desc = L["Set the priority order of the spell, please note that prioritys are only used for the raid debuff module, not the standard buff/debuff module. If you want to disable set to zero."],
			}
			if selectedFilter == "RaidDebuffs" then
				E.Options.args.filters.args.spellGroup.args.stackThreshold = {
					name = L["Stack Threshold"],
					type = "range",
					get = function()
						if selectedFolder or not selectedSpell then
							return 0
						else
							return E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].stackThreshold
						end
					end,
					set = function(info, value) E.global.unitframe['aurafilters'][selectedFilter]['spells'][(spellID or selectedSpell)].stackThreshold = value; UpdateFilterGroup(); UF:Update_AllFrames(); end,
					min = 0, max = 99, step = 1,
					desc = L["The debuff needs to reach this amount of stacks before it is shown. Set to 0 to always show the debuff."],
				}
			end
		end
	end

	 UF:Update_AllFrames();
end

E.Options.args.filters = {
	type = 'group',
	name = L["Filters"],
	order = -10, --Always Last Hehehe
	args = {
		createFilter = {
			order = 1,
			name = L["Create Filter"],
			desc = L["Create a filter, once created a filter can be set inside the buffs/debuffs section of each unit."],
			type = 'input',
			get = function(info) return "" end,
			set = function(info, value)
				E.global.unitframe['aurafilters'][value] = {};
				E.global.unitframe['aurafilters'][value]['spells'] = {};
			end,
		},
		deleteFilter = {
			type = 'input',
			order = 2,
			name = L["Delete Filter"],
			desc = L["Delete a created filter, you cannot delete pre-existing filters, only custom ones."],
			get = function(info) return "" end,
			set = function(info, value)
				if G['unitframe']['aurafilters'][value] then
					E:Print(L["You can't remove a pre-existing filter."])
				else
					E.global.unitframe['aurafilters'][value] = nil;
					selectedFilter = nil;
					selectedSpell = nil;
					E.Options.args.filters.args.filterGroup = nil;
				end
			end,
		},
		selectFilter = {
			order = 3,
			type = 'select',
			name = L["Select Filter"],
			get = function(info) return selectedFilter end,
			set = function(info, value) if value == '' then selectedFilter = nil; selectedSpell = nil; else selectedSpell = nil; selectedFilter = value end; UpdateFilterGroup() end,
			values = function()
				filters = {}
				filters[''] = NONE
				for filter in pairs(E.global.unitframe['aurafilters']) do
					filters[filter] = filter
				end

				filters['Buff Indicator'] = 'Buff Indicator'
				filters['Buff Indicator (Pet)'] = 'Buff Indicator (Pet)'
				filters['Buff Indicator (Profile)'] = 'Buff Indicator (Profile)'
				filters['AuraBar Colors'] = 'AuraBar Colors'
				filters['Debuff Highlight'] = 'Debuff Highlight'
				return filters
			end,
		},
	},
}

local ACD = LibStub("AceConfigDialog-3.0-ElvUI")
function E:SetToFilterConfig(filter)
	selectedFilter = filter or 'Buff Indicator'
	UpdateFilterGroup()
	ACD:SelectGroup("ElvUI", "filters")
end
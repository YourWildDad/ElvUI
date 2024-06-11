local E, L, V, P, G = unpack(ElvUI)

local List = E.Filters.List
local Aura = E.Filters.Aura

-- These are debuffs that are some form of CC
G.unitframe.aurafilters.CCDebuffs = {
	type = 'Whitelist',
	spells = {
	-- Evoker
		[355689]	= List(2), -- Landslide
		[370898]	= List(1), -- Permeating Chill
		[360806]	= List(3), -- Sleep Walk
	-- Death Knight
		[47476]		= List(2), -- Strangulate
		[108194]	= List(4), -- Asphyxiate UH
		[221562]	= List(4), -- Asphyxiate Blood
		[207171]	= List(4), -- Winter is Coming
		[206961]	= List(3), -- Tremble Before Me
		[207167]	= List(4), -- Blinding Sleet
		[212540]	= List(1), -- Flesh Hook (Pet)
		[91807]		= List(1), -- Shambling Rush (Pet)
		[204085]	= List(1), -- Deathchill
		[233395]	= List(1), -- Frozen Center
		[212332]	= List(4), -- Smash (Pet)
		[212337]	= List(4), -- Powerful Smash (Pet)
		[91800]		= List(4), -- Gnaw (Pet)
		[91797]		= List(4), -- Monstrous Blow (Pet)
		[210141]	= List(3), -- Zombie Explosion
	-- Demon Hunter
		[207685]	= List(4), -- Sigil of Misery
		[217832]	= List(3), -- Imprison
		[221527]	= List(5), -- Imprison (Banished version)
		[204490]	= List(2), -- Sigil of Silence
		[179057]	= List(3), -- Chaos Nova
		[211881]	= List(4), -- Fel Eruption
		[205630]	= List(3), -- Illidan's Grasp
		[208618]	= List(3), -- Illidan's Grasp (Afterward)
		[213491]	= List(4), -- Demonic Trample 1
		[208645]	= List(4), -- Demonic Trample 2
	-- Druid
		[81261]		= List(2), -- Solar Beam
		[5211]		= List(4), -- Mighty Bash
		[163505]	= List(4), -- Rake
		[203123]	= List(4), -- Maim
		[202244]	= List(4), -- Overrun
		[99]		= List(4), -- Incapacitating Roar
		[33786]		= List(5), -- Cyclone
		[45334]		= List(1), -- Immobilized
		[102359]	= List(1), -- Mass Entanglement
		[339]		= List(1), -- Entangling Roots
		[2637]		= List(1), -- Hibernate
		[102793]	= List(1), -- Ursol's Vortex
	-- Hunter
		[202933]	= List(2), -- Spider Sting 1
		[233022]	= List(2), -- Spider Sting 2
		[213691]	= List(4), -- Scatter Shot
		[19386]		= List(3), -- Wyvern Sting
		[3355]		= List(3), -- Freezing Trap
		[203337]	= List(5), -- Freezing Trap (PvP Talent)
		[209790]	= List(3), -- Freezing Arrow
		[24394]		= List(4), -- Intimidation
		[117526]	= List(4), -- Binding Shot
		[190927]	= List(1), -- Harpoon
		[201158]	= List(1), -- Super Sticky Tar
		[162480]	= List(1), -- Steel Trap
		[212638]	= List(1), -- Tracker's Net
		[200108]	= List(1), -- Ranger's Net
	-- Mage
		[61721]		= List(3), -- Rabbit
		[61305]		= List(3), -- Black Cat
		[28272]		= List(3), -- Pig
		[28271]		= List(3), -- Turtle
		[126819]	= List(3), -- Porcupine
		[161354]	= List(3), -- Monkey
		[161353]	= List(3), -- Polar Bear
		[61780]		= List(3), -- Turkey
		[161355]	= List(3), -- Penguin
		[161372]	= List(3), -- Peacock
		[277787]	= List(3), -- Direhorn
		[277792]	= List(3), -- Bumblebee
		[118]		= List(3), -- Polymorph
		[82691]		= List(3), -- Ring of Frost
		[31661]		= List(3), -- Dragon's Breath
		[122]		= List(1), -- Frost Nova
		[33395]		= List(1), -- Freeze
		[157997]	= List(1), -- Ice Nova
		[228600]	= List(1), -- Glacial Spike
		[198121]	= List(1), -- Frostbite
	-- Monk
		[119381]	= List(4), -- Leg Sweep
		[202346]	= List(4), -- Double Barrel
		[115078]	= List(4), -- Paralysis
		[198909]	= List(3), -- Song of Chi-Ji
		[202274]	= List(3), -- Incendiary Brew
		[233759]	= List(2), -- Grapple Weapon
		[123407]	= List(1), -- Spinning Fire Blossom
		[116706]	= List(1), -- Disable
		[232055]	= List(4), -- Fists of Fury
	-- Paladin
		[853]		= List(3), -- Hammer of Justice
		[20066]		= List(3), -- Repentance
		[105421]	= List(3), -- Blinding Light
		[31935]		= List(2), -- Avenger's Shield
		[217824]	= List(2), -- Shield of Virtue
		[205290]	= List(3), -- Wake of Ashes
	-- Priest
		[9484]		= List(3), -- Shackle Undead
		[200196]	= List(4), -- Holy Word: Chastise
		[200200]	= List(4), -- Holy Word: Chastise
		[226943]	= List(3), -- Mind Bomb
		[605]		= List(5), -- Mind Control
		[8122]		= List(3), -- Psychic Scream
		[15487]		= List(2), -- Silence
		[64044]		= List(1), -- Psychic Horror
		[453]		= List(5), -- Mind Soothe
	-- Rogue
		[2094]		= List(4), -- Blind
		[6770]		= List(4), -- Sap
		[1776]		= List(4), -- Gouge
		[1330]		= List(2), -- Garrote - Silence
		[207777]	= List(2), -- Dismantle
		[408]		= List(4), -- Kidney Shot
		[1833]		= List(4), -- Cheap Shot
		[207736]	= List(5), -- Shadowy Duel (Smoke effect)
		[212182]	= List(5), -- Smoke Bomb
	-- Shaman
		[51514]		= List(3), -- Hex
		[211015]	= List(3), -- Hex (Cockroach)
		[211010]	= List(3), -- Hex (Snake)
		[211004]	= List(3), -- Hex (Spider)
		[210873]	= List(3), -- Hex (Compy)
		[196942]	= List(3), -- Hex (Voodoo Totem)
		[269352]	= List(3), -- Hex (Skeletal Hatchling)
		[277778]	= List(3), -- Hex (Zandalari Tendonripper)
		[277784]	= List(3), -- Hex (Wicker Mongrel)
		[118905]	= List(3), -- Static Charge
		[77505]		= List(4), -- Earthquake (Knocking down)
		[118345]	= List(4), -- Pulverize (Pet)
		[204399]	= List(3), -- Earthfury
		[204437]	= List(3), -- Lightning Lasso
		[157375]	= List(4), -- Gale Force
		[64695]		= List(1), -- Earthgrab
	-- Warlock
		[710]		= List(5), -- Banish
		[6789]		= List(3), -- Mortal Coil
		[118699]	= List(3), -- Fear
		[6358]		= List(3), -- Seduction (Succub)
		[171017]	= List(4), -- Meteor Strike (Infernal)
		[22703]		= List(4), -- Infernal Awakening (Infernal CD)
		[30283]		= List(3), -- Shadowfury
		[89766]		= List(4), -- Axe Toss
		[233582]	= List(1), -- Entrenched in Flame
	-- Warrior
		[5246]		= List(4), -- Intimidating Shout
		[132169]	= List(4), -- Storm Bolt
		[132168]	= List(4), -- Shockwave
		[199085]	= List(4), -- Warpath
		[199042]	= List(1), -- Thunderstruck
		[236077]	= List(2), -- Disarm
		[105771]	= List(2), -- Charge
	-- Racial
		[20549]		= List(4), -- War Stomp
		[107079]	= List(4), -- Quaking Palm
	},
}

-- These are buffs that can be considered 'protection' buffs
G.unitframe.aurafilters.TurtleBuffs = {
	type = 'Whitelist',
	spells = {
	-- Evoker
		[378464]	= List(), -- Nullifying Shroud (PvP)
		[363916]	= List(), -- Obsidian Scales
		[374348]	= List(), -- Renewing Blaze
		[357170]	= List(), -- Time Dilation
	-- Death Knight
		[48707]		= List(), -- Anti-Magic Shell
		[81256]		= List(), -- Dancing Rune Weapon
		[55233]		= List(), -- Vampiric Blood
		[193320]	= List(), -- Umbilicus Eternus
		[219809]	= List(), -- Tombstone
		[48792]		= List(), -- Icebound Fortitude
		[207319]	= List(), -- Corpse Shield
		[194844]	= List(), -- BoneStorm
		[145629]	= List(), -- Anti-Magic Zone
		[194679]	= List(), -- Rune Tap
	-- Demon Hunter
		[207811]	= List(), -- Nether Bond (DH)
		[207810]	= List(), -- Nether Bond (Target)
		[187827]	= List(), -- Metamorphosis
		[263648]	= List(), -- Soul Barrier
		[209426]	= List(), -- Darkness
		[196555]	= List(), -- Netherwalk
		[212800]	= List(), -- Blur
		[188499]	= List(), -- Blade Dance
		[203819]	= List(), -- Demon Spikes
	-- Druid
		[102342]	= List(), -- Ironbark
		[61336]		= List(), -- Survival Instincts
		[210655]	= List(), -- Protection of Ashamane
		[22812]		= List(), -- Barkskin
		[200851]	= List(), -- Rage of the Sleeper
		[234081]	= List(), -- Celestial Guardian
		[202043]	= List(), -- Protector of the Pack 1
		[201940]	= List(), -- Protector of the Pack 2
		[201939]	= List(), -- Protector of the Pack 3
		[192081]	= List(), -- Ironfur
		[50334]		= List(), -- Berserk (Guardian)
	-- Hunter
		[186265]	= List(), -- Aspect of the Turtle
		[53480]		= List(), -- Roar of Sacrifice
		[202748]	= List(), -- Survival Tactics
	-- Mage
		[414658]	= List(), -- Ice Cold
		[45438]		= List(), -- Ice Block
		[110960]	= List(), -- Greater Invisibility
		[198111]	= List(), -- Temporal Shield
		[198065]	= List(), -- Prismatic Cloak
		[11426]		= List(), -- Ice Barrier
		[235313]	= List(), -- Blazing Barrier
		[235450]	= List(), -- Prismatic Barrier
		[110909]	= List(), -- Alter Time
		[342246]	= List(), -- Alter Time
	-- Monk
		[122783]	= List(), -- Diffuse Magic
		[122278]	= List(), -- Dampen Harm
		[125174]	= List(), -- Touch of Karma
		[201318]	= List(), -- Fortifying Elixir
		[202248]	= List(), -- Guided Meditation
		[120954]	= List(), -- Fortifying Brew
		[116849]	= List(), -- Life Cocoon
		[202162]	= List(), -- Guard
		[215479]	= List(), -- Ironskin Brew
		[353319]	= List(), -- Peaceweaver (PvP)
		[353362]	= List(), -- Dematerialize (PvP)
	-- Paladin
		[642]		= List(), -- Divine Shield
		[498]		= List(), -- Divine Protection
		[205191]	= List(), -- Eye for an Eye
		[184662]	= List(), -- Shield of Vengeance
		[1022]		= List(), -- Blessing of Protection
		[6940]		= List(), -- Blessing of Sacrifice
		[204018]	= List(), -- Blessing of Spellwarding
		[199507]	= List(), -- Spreading The Word: Protection
		[216857]	= List(), -- Guarded by the Light
		[228049]	= List(), -- Guardian of the Forgotten Queen
		[31850]		= List(), -- Ardent Defender
		[86659]		= List(), -- Guardian of Ancien Kings
		[212641]	= List(), -- Guardian of Ancien Kings (Glyph of the Queen)
		[209388]	= List(), -- Bulwark of Order
		[132403]	= List(), -- Shield of the Righteous
	-- Priest
		[81782]		= List(), -- Power Word: Barrier
		[47585]		= List(), -- Dispersion
		[19236]		= List(), -- Desperate Prayer
		[27827]		= List(), -- Spirit of Redemption
		[197268]	= List(), -- Ray of Hope
		[47788]		= List(), -- Guardian Spirit
		[33206]		= List(), -- Pain Suppression
	-- Rogue
		[5277]		= List(), -- Evasion
		[31224]		= List(), -- Cloak of Shadows
		[1966]		= List(), -- Feint
		[199754]	= List(), -- Riposte
		[45182]		= List(), -- Cheating Death
		[199027]	= List(), -- Veil of Midnight
	-- Shaman
		[325174]	= List(), -- Spirit Link
		[974]		= List(), -- Earth Shield
		[207654]	= List(), -- Servant of the Queen
		[108271]	= List(), -- Astral Shift
		[207498]	= List(), -- Ancestral Protection
	-- Warlock
		[108416]	= List(), -- Dark Pact
		[104773]	= List(), -- Unending Resolve
		[221715]	= List(), -- Essence Drain
		[212295]	= List(), -- Nether Ward
	-- Warrior
		[118038]	= List(), -- Die by the Sword
		[184364]	= List(), -- Enraged Regeneration
		[209484]	= List(), -- Tactical Advance
		[97463]		= List(), -- Commanding Shout
		[213915]	= List(), -- Mass Spell Reflection
		[199038]	= List(), -- Leave No Man Behind
		[223658]	= List(), -- Safeguard
		[147833]	= List(), -- Intervene
		[198760]	= List(), -- Intercept
		[12975]		= List(), -- Last Stand
		[871]		= List(), -- Shield Wall
		[23920]		= List(), -- Spell Reflection
		[227744]	= List(), -- Ravager
		[203524]	= List(), -- Neltharion's Fury
		[190456]	= List(), -- Ignore Pain
		[132404]	= List(), -- Shield Block
	-- Racial
		[65116]		= List(), -- Stoneform
	-- Potion
		[251231]	= List(), -- Steelskin Potion
	-- Covenant
		[324867]	= List(), -- Fleshcraft (Necrolord)
	-- PvP
		[363522]	= List(), -- Gladiator's Eternal Aegis
		[362699]	= List(), -- Gladiator's Resolve
	},
}

G.unitframe.aurafilters.PlayerBuffs = {
	type = 'Whitelist',
	spells = {
	-- Evoker
		[363916]	= List(), -- Obsidian Scales
		[374348]	= List(), -- Renewing Blaze
		[375087]	= List(), -- Dragonrage
		[370553]	= List(), -- Tip the Scales
		[358267]	= List(), -- Hover
		[357210]	= List(), -- Deep Breath
		[371807]	= List(), -- Recall
		[395296]	= List(), -- Ebon Might < self
		[395152]	= List(), -- Ebon Might < others
	-- Death Knight
		[48707]		= List(), -- Anti-Magic Shell
		[81256]		= List(), -- Dancing Rune Weapon
		[55233]		= List(), -- Vampiric Blood
		[193320]	= List(), -- Umbilicus Eternus
		[219809]	= List(), -- Tombstone
		[48792]		= List(), -- Icebound Fortitude
		[207319]	= List(), -- Corpse Shield
		[194844]	= List(), -- BoneStorm
		[145629]	= List(), -- Anti-Magic Zone
		[194679]	= List(), -- Rune Tap
		[51271]		= List(), -- Pillar of Frost
		[207256]	= List(), -- Obliteration
		[152279]	= List(), -- Breath of Sindragosa
		[233411]	= List(), -- Blood for Blood
		[212552]	= List(), -- Wraith Walk
		[343294]	= List(), -- Soul Reaper
		[194918]	= List(), -- Blighted Rune Weapon
		[48265]		= List(), -- Death's Advance
		[49039]		= List(), -- Lichborne
		[47568]		= List(), -- Empower Rune Weapon
	-- Demon Hunter
		[207811]	= List(), -- Nether Bond (DH)
		[207810]	= List(), -- Nether Bond (Target)
		[187827]	= List(), -- Metamorphosis
		[263648]	= List(), -- Soul Barrier
		[209426]	= List(), -- Darkness
		[196555]	= List(), -- Netherwalk
		[212800]	= List(), -- Blur
		[188499]	= List(), -- Blade Dance
		[203819]	= List(), -- Demon Spikes
		[206804]	= List(), -- Rain from Above
		[211510]	= List(), -- Solitude
		[162264]	= List(), -- Metamorphosis
		[205629]	= List(), -- Demonic Trample
		[188501]	= List(), -- Spectral Sight
	-- Druid
		[102342]	= List(), -- Ironbark
		[61336]		= List(), -- Survival Instincts
		[210655]	= List(), -- Protection of Ashamane
		[22812]		= List(), -- Barkskin
		[200851]	= List(), -- Rage of the Sleeper
		[234081]	= List(), -- Celestial Guardian
		[202043]	= List(), -- Protector of the Pack 1
		[201940]	= List(), -- Protector of the Pack 2
		[201939]	= List(), -- Protector of the Pack 3
		[192081]	= List(), -- Ironfur
		[29166]		= List(), -- Innervate
		[208253]	= List(), -- Essence of G'Hanir
		[194223]	= List(), -- Celestial Alignment
		[102560]	= List(), -- Incarnation: Chosen of Elune
		[390414]	= List(), -- Orbital Strike (Incarnation: Chosen of Elune)
		[102543]	= List(), -- Incarnation: King of the Jungle
		[102558]	= List(), -- Incarnation: Guardian of Ursoc
		[117679]	= List(), -- Incarnation
		[106951]	= List(), -- Berserk (Feral)
		[50334]		= List(), -- Berserk (Guardian)
		[5217]		= List(), -- Tiger's Fury
		[1850]		= List(), -- Dash
		[137452]	= List(), -- Displacer Beast
		[102416]	= List(), -- Wild Charge
		[77764]		= List(), -- Stampeding Roar (Cat)
		[77761]		= List(), -- Stampeding Roar (Bear)
		[305497]	= List(), -- Thorns
		[234084]	= List(), -- Moon and Stars (PvP)
		[22842]		= List(), -- Frenzied Regeneration
	-- Hunter
		[186265]	= List(), -- Aspect of the Turtle
		[53480]		= List(), -- Roar of Sacrifice
		[202748]	= List(), -- Survival Tactics
		[62305]		= List(), -- Master's Call (it's this one or the other)
		[54216]		= List(), -- Master's Call
		[288613]	= List(), -- Trueshot
		[260402]	= List(), -- Double Tap
		[193530]	= List(), -- Aspect of the Wild
		[19574]		= List(), -- Bestial Wrath
		[186289]	= List(), -- Aspect of the Eagle
		[186257]	= List(), -- Aspect of the Cheetah
		[118922]	= List(), -- Posthaste
		[90355]		= List(), -- Ancient Hysteria (Pet)
		[160452]	= List(), -- Netherwinds (Pet)
		[266779]	= List(), -- Coordinated Assault
	-- Mage
		[414658]	= List(), -- Ice Cold
		[45438]		= List(), -- Ice Block
		[110960]	= List(), -- Greater Invisibility
		[198111]	= List(), -- Temporal Shield
		[198065]	= List(), -- Prismatic Cloak
		[11426]		= List(), -- Ice Barrier
		[235313]	= List(), -- Blazing Barrier
		[235450]	= List(), -- Prismatic Barrier
		[110909]	= List(), -- Alter Time
		[342246]	= List(), -- Alter Time
		[190319]	= List(), -- Combustion
		[80353]		= List(), -- Time Warp
		[12472]		= List(), -- Icy Veins
		[12042]		= List(), -- Arcane Power
		[116014]	= List(), -- Rune of Power
		[198144]	= List(), -- Ice Form
		[108839]	= List(), -- Ice Floes
		[205025]	= List(), -- Presence of Mind
		[198158]	= List(), -- Mass Invisibility
		[221404]	= List(), -- Burning Determination
		[324220]	= List(), -- Deathborne (Covenant/Necrolord)
	-- Monk
		[122783]	= List(), -- Diffuse Magic
		[122278]	= List(), -- Dampen Harm
		[125174]	= List(), -- Touch of Karma
		[201318]	= List(), -- Fortifying Elixir
		[202248]	= List(), -- Guided Meditation
		[120954]	= List(), -- Fortifying Brew
		[116849]	= List(), -- Life Cocoon
		[202162]	= List(), -- Guard
		[215479]	= List(), -- Ironskin Brew
		[152173]	= List(), -- Serenity
		[137639]	= List(), -- Storm, Earth, and Fire
		[213664]	= List(), -- Nimble Brew
		[201447]	= List(), -- Ride the Wind
		[195381]	= List(), -- Healing Winds
		[116841]	= List(), -- Tiger's Lust
		[119085]	= List(), -- Chi Torpedo
		[199407]	= List(), -- Light on Your Feet
		[209584]	= List(), -- Zen Focus Tea
	-- Paladin
		[642]		= List(), -- Divine Shield
		[498]		= List(), -- Divine Protection
		[205191]	= List(), -- Eye for an Eye
		[184662]	= List(), -- Shield of Vengeance
		[1022]		= List(), -- Blessing of Protection
		[6940]		= List(), -- Blessing of Sacrifice
		[204018]	= List(), -- Blessing of Spellwarding
		[199507]	= List(), -- Spreading The Word: Protection
		[216857]	= List(), -- Guarded by the Light
		[228049]	= List(), -- Guardian of the Forgotten Queen
		[31850]		= List(), -- Ardent Defender
		[86659]		= List(), -- Guardian of Ancien Kings
		[212641]	= List(), -- Guardian of Ancien Kings (Glyph of the Queen)
		[209388]	= List(), -- Bulwark of Order
		[132403]	= List(), -- Shield of the Righteous
		[31884]		= List(), -- Avenging Wrath
		[105809]	= List(), -- Holy Avenger
		[231895]	= List(), -- Crusade
		[200652]	= List(), -- Tyr's Deliverance
		[216331]	= List(), -- Avenging Crusader
		[1044]		= List(), -- Blessing of Freedom
		[305395] 	= List(), -- Blessing of Freedom (Unbound Freedom - Ret/Prot PvP)
		[210256]	= List(), -- Blessing of Sanctuary
		[199545]	= List(), -- Steed of Glory
		[210294]	= List(), -- Divine Favor
		[221886]	= List(), -- Divine Steed
		[31821]		= List(), -- Aura Mastery
	-- Priest
		[81782]		= List(), -- Power Word: Barrier
		[47585]		= List(), -- Dispersion
		[19236]		= List(), -- Desperate Prayer
		[27827]		= List(), -- Spirit of Redemption
		[197268]	= List(), -- Ray of Hope
		[47788]		= List(), -- Guardian Spirit
		[33206]		= List(), -- Pain Suppression
		[200183]	= List(), -- Apotheosis
		[10060]		= List(), -- Power Infusion
		[47536]		= List(), -- Rapture
		[194249]	= List(), -- Voidform
		[197862]	= List(), -- Archangel
		[197871]	= List(), -- Dark Archangel
		[197874]	= List(), -- Dark Archangel
		[215769]	= List(), -- Spirit of Redemption
		[213610]	= List(), -- Holy Ward
		[121557]	= List(), -- Angelic Feather
		[65081]		= List(), -- Body and Soul
		[197767]	= List(), -- Speed of the Pious
		[210980]	= List(), -- Focus in the Light
		[221660]	= List(), -- Holy Concentration
		[15286]		= List(), -- Vampiric Embrace
	-- Rogue
		[315496]	= List(), -- Slice and Dice
		[5277]		= List(), -- Evasion
		[31224]		= List(), -- Cloak of Shadows
		[1966]		= List(), -- Feint
		[199754]	= List(), -- Riposte
		[45182]		= List(), -- Cheating Death
		[199027]	= List(), -- Veil of Midnight
		[121471]	= List(), -- Shadow Blades
		[13750]		= List(), -- Adrenaline Rush
		[51690]		= List(), -- Killing Spree
		[185422]	= List(), -- Shadow Dance
		[198368]	= List(), -- Take Your Cut
		[198027]	= List(), -- Turn the Tables
		[213985]	= List(), -- Thief's Bargain
		[197003]	= List(), -- Maneuverability
		[212198]	= List(), -- Crimson Vial
		[185311]	= List(), -- Crimson Vial
		[209754]	= List(), -- Boarding Party
		[36554]		= List(), -- Shadowstep
		[2983]		= List(), -- Sprint
		[202665]	= List(), -- Curse of the Dreadblades (Self Debuff)
	-- Shaman
		[325174]	= List(), -- Spirit Link
		[974]		= List(), -- Earth Shield
		[207654]	= List(), -- Servant of the Queen
		[108271]	= List(), -- Astral Shift
		[207498]	= List(), -- Ancestral Protection
		[209385]	= List(), -- Windfury Totem
		[208963]	= List(), -- Skyfury Totem
		[204945]	= List(), -- Doom Winds
		[205495]	= List(), -- Stormkeeper
		[208416]	= List(), -- Sense of Urgency
		[2825]		= List(), -- Bloodlust
		[16166]		= List(), -- Elemental Mastery
		[167204]	= List(), -- Feral Spirit
		[114050]	= List(), -- Ascendance (Elem)
		[114051]	= List(), -- Ascendance (Enh)
		[114052]	= List(), -- Ascendance (Resto)
		[79206]		= List(), -- Spiritwalker's Grace
		[58875]		= List(), -- Spirit Walk
		[157384]	= List(), -- Eye of the Storm
		[192082]	= List(), -- Wind Rush
		[2645]		= List(), -- Ghost Wolf
		[32182]		= List(), -- Heroism
		[108281]	= List(), -- Ancestral Guidance
	-- Warlock
		[108416]	= List(), -- Dark Pact
		[113860]	= List(), -- Dark Soul: Misery
		[113858]	= List(), -- Dark Soul: Instability
		[104773]	= List(), -- Unending Resolve
		[221715]	= List(), -- Essence Drain
		[212295]	= List(), -- Nether Ward
		[212284]	= List(), -- Firestone
		[196098]	= List(), -- Soul Harvest
		[221705]	= List(), -- Casting Circle
		[111400]	= List(), -- Burning Rush
		[196674]	= List(), -- Planeswalker
	-- Warrior
		[118038]	= List(), -- Die by the Sword
		[184364]	= List(), -- Enraged Regeneration
		[209484]	= List(), -- Tactical Advance
		[97463]		= List(), -- Commanding Shout
		[213915]	= List(), -- Mass Spell Reflection
		[199038]	= List(), -- Leave No Man Behind
		[223658]	= List(), -- Safeguard
		[147833]	= List(), -- Intervene
		[198760]	= List(), -- Intercept
		[12975]		= List(), -- Last Stand
		[871]		= List(), -- Shield Wall
		[23920]		= List(), -- Spell Reflection
		[227744]	= List(), -- Ravager
		[203524]	= List(), -- Neltharion's Fury
		[190456]	= List(), -- Ignore Pain
		[132404]	= List(), -- Shield Block
		[1719]		= List(), -- Battle Cry
		[107574]	= List(), -- Avatar
		[227847]	= List(), -- Bladestorm (Arm)
		[46924]		= List(), -- Bladestorm (Fury)
		[118000]	= List(), -- Dragon Roar
		[199261]	= List(), -- Death Wish
		[18499]		= List(), -- Berserker Rage
		[202164]	= List(), -- Bounding Stride
		[215572]	= List(), -- Frothing Berserker
		[199203]	= List(), -- Thirst for Battle
	-- Racials
		[256948]	= List(), -- Spatial Rift
		[65116]		= List(), -- Stoneform
		[59547]		= List(), -- Gift of the Naaru
		[20572]		= List(), -- Blood Fury
		[26297]		= List(), -- Berserking
		[68992]		= List(), -- Darkflight
		[58984]		= List(), -- Shadowmeld
	},
}

-- Buffs that we don't really need to see
G.unitframe.aurafilters.Blacklist = {
	type = 'Blacklist',
	spells = {
		[8326]		= List(), -- Ghost
		[8733]		= List(), -- Blessing of Blackfathom
		[15007]		= List(), -- Ress Sickness
		[23445]		= List(), -- Evil Twin
		[24755]		= List(), -- Tricked or Treated
		[25163]		= List(), -- Oozeling's Disgusting Aura
		[25771]		= List(), -- Forbearance
		[26013]		= List(), -- Deserter
		[36032]		= List(), -- Arcane Charge
		[36893]		= List(), -- Transporter Malfunction
		[36900]		= List(), -- Soul Split: Evil!
		[36901]		= List(), -- Soul Split: Good
		[41425]		= List(), -- Hypothermia
		[49822]		= List(), -- Bloated
		[55711]		= List(), -- Weakened Heart
		[57723]		= List(), -- Exhaustion (heroism debuff)
		[57724]		= List(), -- Sated (lust debuff)
		[58539]		= List(), -- Watcher's Corpse
		[71041]		= List(), -- Dungeon Deserter
		[80354]		= List(), -- Temporal Displacement (timewarp debuff)
		[89140]		= List(), -- Demonic Rebirth: Cooldown
		[95809]		= List(), -- Insanity debuff (hunter pet heroism: ancient hysteria)
		[96041]		= List(), -- Stink Bombed
		[97821]		= List(), -- Void-Touched
		[113942]	= List(), -- Demonic: Gateway
		[117870]	= List(), -- Touch of The Titans
		[123981]	= List(), -- Perdition
		[124273]	= List(), -- Stagger
		[124274]	= List(), -- Stagger
		[124275]	= List(), -- Stagger
		[195776]	= List(), -- Moonfeather Fever
		[196342]	= List(), -- Zanzil's Embrace
		[206150]	= List(), -- Challenger's Burden SL
		[206151]	= List(), -- Challenger's Burden BfA
		[206662]	= List(), -- Experience Eliminated (in range)
		[234143]	= List(), -- Temptation (Upper Karazhan Ring Debuff)
		[287825]	= List(), -- Lethargy debuff (fight or flight)
		[306600]	= List(), -- Experience Eliminated (oor - 5m)
		[313015]	= List(), -- Recently Failed (Mechagnome racial)
		[322695]	= List(), -- Drained
		[328891]	= List(), -- A Gilded Perspective
		[348443]	= List(), -- Experience Eliminated
		[374037]	= List(), -- Overwhelming Rage
		[383600]	= List(), -- Surrounding Storm (Strunraan)
		[390106]	= List(), -- Riding Along
		[392960]	= List(), -- Waygate Travel
		[392992]	= List(), -- Silent Lava
		[393798]	= List(), -- Activated Defense Systems
		[418990]	= List(), -- Wicker Men's Curse
	},
}

-- A list of important buffs that we always want to see
G.unitframe.aurafilters.Whitelist = {
	type = 'Whitelist',
	spells = {
	-- WoW: Remix TEMPORARY STUFF
		[440393]	= List(), -- Timerunner's Advantage
		[424143] 	= List(), -- WoW Remix: Mists of Pandaria
	-- Haste effects
		[2825]		= List(), -- [Shaman] Bloodlust
		[32182]		= List(), -- [Shaman] Heroism
		[80353]		= List(), -- [Mage] Time Warp
		[90355]		= List(), -- [Hunter] Ancient Hysteria
		[390386]	= List(), -- [Evoker] Fury of the Aspects
	-- Paladin
		[31821]		= List(), -- Aura Mastery
		[1022]		= List(), -- Blessing of Protection
		[204018]	= List(), -- Blessing of Spellwarding
		[6940]		= List(), -- Blessing of Sacrifice
		[1044]		= List(), -- Blessing of Freedom
	-- Priest
		[47788]		= List(), -- Guardian Spirit
		[33206]		= List(), -- Pain Suppression
		[62618]		= List(), -- Power Word: Barrier
	-- Monk
		[116849]	= List(), -- Life Cocoon
	-- Druid
		[102342]	= List(), -- Ironbark
	-- Shaman
		[325174]	= List(), -- Spirit Link
		[20608]		= List(), -- Reincarnation
	-- Other
		[97462]		= List(), -- Rallying Cry
		[196718]	= List(), -- Darkness
	},
}

-- RAID DEBUFFS: This should be pretty self explainitory
G.unitframe.aurafilters.RaidDebuffs = {
	type = 'Whitelist',
	spells = {
	----------------------------------------------------------
	------------------------- General ------------------------
	----------------------------------------------------------
	-- Misc
		[160029] = List(), -- Resurrecting (Pending CR)
	----------------------------------------------------------
	-------------------- Mythic+ Specific --------------------
	----------------------------------------------------------
	-- General Affixes
		[226512] = List(), -- Sanguine
		[240559] = List(), -- Grievous
		[240443] = List(), -- Bursting
		[409492] = List(), -- Afflicted Cry
	----------------------------------------------------------
	---------------- The War Within Dungeons -----------------
	----------------------------------------------------------
	-- The Rookery
	-- The Stonevault
	-- Priory of the Sacred Flame
	-- City of Threads
	-- Cinderbrew Meadery
	-- Darkflame Cleft
	-- The Dawnbreaker
	-- Old City
	----------------------------------------------------------
	--------------- The War Within (Season 1) ----------------
	----------------------------------------------------------
	-- Mists of Tirna Scithe
	-- The Necrotic Wake
	-- Siege of Boralus
	-- Grim Batol
	---------------------------------------------------------
	------------------- Nerub'ar Palace ---------------------
	---------------------------------------------------------
	-- Ulgrax the Devourer
	-- The Bloodbound Horror
	-- Sikran
	-- Rasha'nan
	-- Eggtender Ovi'nax
	-- Nexus-Princess Ky'veza
	-- The Silken Court
	-- Queen Ansurek
	},
}

--[[
	RAID BUFFS:
	Buffs that are provided by NPCs in raid or other PvE content.
	This can be buffs put on other enemies or on players.
]]
G.unitframe.aurafilters.RaidBuffsElvUI = {
	type = 'Whitelist',
	spells = {
	----------------------------------------------------------
	-------------------- Mythic+ Specific --------------------
	----------------------------------------------------------
	-- Mythic+ General
		[209859] = List(), -- Bolster
		[178658] = List(), -- Raging
		[226510] = List(), -- Sanguine
	----------------------------------------------------------
	---------------- The War Within Dungeons -----------------
	----------------------------------------------------------
	-- The Rookery
	-- The Stonevault
	-- Priory of the Sacred Flame
	-- City of Threads
	-- Cinderbrew Meadery
	-- Darkflame Cleft
	-- The Dawnbreaker
	-- Old City
	----------------------------------------------------------
	--------------- The War Within (Season 1) ----------------
	----------------------------------------------------------
	-- Mists of Tirna Scithe
	-- The Necrotic Wake
	-- Siege of Boralus
	-- Grim Batol
	---------------------------------------------------------
	------------------- Nerub'ar Palace ---------------------
	---------------------------------------------------------
	-- Ulgrax the Devourer
	-- The Bloodbound Horror
	-- Sikran
	-- Rasha'nan
	-- Eggtender Ovi'nax
	-- Nexus-Princess Ky'veza
	-- The Silken Court
	-- Queen Ansurek
	---------------------------------------------------------
	----------------------- Open World ----------------------
	---------------------------------------------------------
	-- Korthia
		[354840] = List(), -- Rift Veiled (Silent Soulstalker, Deadsoul Hatcher, Screaming Shade)
		[355249] = List(), -- Anima Gorged (Consumption)
	-- Zereth Mortis
		[360945] = List(), -- Creation Catalyst Overcharge (Nascent Servitor)
		[366309] = List(), -- Meltdown (Destabilized Core)
		[365596] = List(), -- Overload (Destabilized Core)
		[360750] = List(), -- Aurelid Lure
	-- Emerald Dream
		[420009] = List(), -- Corrupting Sparks (Splinterlimb)
	},
}

G.unitframe.aurawatch = {
	GLOBAL = {},
	EVOKER = {
		-- Preservation
		[355941]	= Aura(355941, nil, 'TOPRIGHT', {0.33, 0.33, 0.77}), -- Dream Breath
		[376788]	= Aura(376788, nil, 'TOPRIGHT', {0.25, 0.25, 0.58}, nil, nil, nil, nil, -20), -- Dream Breath (echo)
		[363502]	= Aura(363502, nil, 'BOTTOMLEFT', {0.33, 0.33, 0.70}), -- Dream Flight
		[366155]	= Aura(366155, nil, 'BOTTOMRIGHT', {0.14, 1.00, 0.88}), -- Reversion
		[367364]	= Aura(367364, nil, 'BOTTOMRIGHT', {0.09, 0.69, 0.61}, nil, nil, nil, nil, -20), -- Reversion (echo)
		[373267]	= Aura(373267, nil, 'RIGHT', {0.82, 0.29, 0.24}), -- Life Bind (Verdant Embrace)
		[364343]	= Aura(364343, nil, 'TOP', {0.13, 0.87, 0.50}), -- Echo
		[357170]	= Aura(357170, nil, 'BOTTOM', {0.11, 0.57, 0.71}), -- Time Dilation
		-- Augmentation
		[360827]	= Aura(360827, nil, 'TOPRIGHT', {0.33, 0.33, 0.77}), -- Blistering Scales
		[410089]	= Aura(410089, nil, 'TOP', {0.13, 0.87, 0.50}), -- Prescience
		[395152]	= Aura(395152, nil, 'BOTTOMRIGHT', {0.98, 0.44, 0.00}), -- Ebon Might < others
		[406732]	= Aura(406732, nil, 'RIGHT', {0.82, 0.29, 0.24}), -- Spatial Paradox < on yourself
		[406789]	= Aura(406789, nil, 'RIGHT', {0.82, 0.29, 0.24}), -- Spatial Paradox < on the partner
	},
	ROGUE = {
		[57934]		= Aura(57934, nil, 'TOPRIGHT', {0.89, 0.09, 0.05}), -- Tricks of the Trade
	},
	WARRIOR = {
		[3411]		= Aura(3411, nil, 'TOPRIGHT', {0.89, 0.09, 0.05}), -- Intervene
	},
	PRIEST = {
		[194384]	= Aura(194384, nil, 'TOPRIGHT', {1, 1, 0.66}), -- Atonement
		[214206]	= Aura(214206, nil, 'TOPRIGHT', {1, 1, 0.66}), -- Atonement (PvP)
		[17]		= Aura(17, nil, 'TOPLEFT', {0.7, 0.7, 0.7}, true), -- Power Word: Shield
		[41635]		= Aura(41635, nil, 'BOTTOMRIGHT', {0.2, 0.7, 0.2}), -- Prayer of Mending
		[193065]	= Aura(193065, nil, 'BOTTOMRIGHT', {0.54, 0.21, 0.78}, nil, nil, nil, nil, -20), -- Masochism
		[139]		= Aura(139, nil, 'BOTTOMLEFT', {0.4, 0.7, 0.2}), -- Renew
		[6788]		= Aura(6788, nil, 'BOTTOMLEFT', {0.89, 0.1, 0.1}, nil, nil, nil, nil, 20), -- Weakened Soul
		[10060]		= Aura(10060, nil, 'RIGHT', {1, 0.81, 0.11}, true), -- Power Infusion
		[77489]		= Aura(77489, nil, 'TOP', {0.75, 1.00, 0.30}), -- Echo of Light
		[33206]		= Aura(33206, nil, 'BOTTOM', {0.47, 0.35, 0.74}, true), -- Pain Suppression
		[47788]		= Aura(47788, nil, 'BOTTOM', {0.86, 0.45, 0}, true, nil, nil, nil, -20), -- Guardian Spirit
	},
	DRUID = {
		[774]		= Aura(774, nil, 'TOPRIGHT', {0.8, 0.4, 0.8}), -- Rejuvenation
		[33763]		= Aura(33763, nil, 'TOPLEFT', {0.4, 0.8, 0.2}), -- Lifebloom
		[188550]	= Aura(188550, nil, 'TOPLEFT', {0.4, 0.8, 0.2}), -- Lifebloom (Shadowlands Legendary)
		[48438]		= Aura(48438, nil, 'BOTTOMRIGHT', {0.8, 0.4, 0}), -- Wild Growth
		[8936]		= Aura(8936, nil, 'BOTTOMLEFT', {0.2, 0.8, 0.2}), -- Regrowth
		[155777]	= Aura(155777, nil, 'RIGHT', {0.8, 0.4, 0.8}), -- Germination
		[102351]	= Aura(102351, nil, 'LEFT', {0.2, 0.8, 0.8}), -- Cenarion Ward (Initial Buff)
		[102352]	= Aura(102352, nil, 'LEFT', {0.2, 0.8, 0.8}), -- Cenarion Ward (HoT)
		[207386]	= Aura(207386, nil, 'TOP', {0.4, 0.2, 0.8}), -- Spring Blossoms
		[203554]	= Aura(203554, nil, 'TOP', {1, 1, 0.4}, nil, nil, nil, nil, -20), -- Focused Growth (PvP)
		[200389]	= Aura(200389, nil, 'BOTTOM', {1, 1, 0.4}, nil, nil, nil, nil, -20), -- Cultivation
		[391891]	= Aura(391891, nil, 'BOTTOM', {0.01, 0.75, 0.60}, nil, nil, nil, nil, -20), -- Adaptive Swarm
		[157982]	= Aura(157982, nil, 'BOTTOM', {0.75, 0.75, 0.75}), -- Tranquility
	},
	PALADIN = {
		[53563]		= Aura(53563, nil, 'TOPRIGHT', {0.7, 0.3, 0.7}), -- Beacon of Light
		[156910]	= Aura(156910, nil, 'TOPRIGHT', {0.7, 0.3, 0.7}), -- Beacon of Faith
		[200025]	= Aura(200025, nil, 'TOPRIGHT', {0.7, 0.3, 0.7}), -- Beacon of Virtue
		[287280]	= Aura(287280, nil, 'TOPLEFT', {0.2, 0.8, 0.2}), -- Glimmer of Light (T50 Talent)
		[1022]		= Aura(1022, nil, 'BOTTOMRIGHT', {0.2, 0.2, 1}, true), -- Blessing of Protection
		[1044]		= Aura(1044, nil, 'BOTTOMRIGHT', {0.89, 0.45, 0}, true), -- Blessing of Freedom
		[6940]		= Aura(6940, nil, 'BOTTOMRIGHT', {0.89, 0.1, 0.1}, true), -- Blessing of Sacrifice
		[204018]	= Aura(204018, nil, 'BOTTOMRIGHT', {0.2, 0.2, 1}, true), -- Blessing of Spellwarding
		[223306]	= Aura(223306, nil, 'BOTTOMLEFT', {0.7, 0.7, 0.3}), -- Bestow Faith
		[157047]	= Aura(157047, nil, 'TOP', {0.15, 0.58, 0.84}), -- Saved by the Light (T25 Talent)
		[148039]	= Aura(148039, nil, 'BOTTOM', {0.98, 0.50, 0.11}), -- Barrier of Faith (accumulation)
		[395180]	= Aura(395180, nil, 'BOTTOM', {0.93, 0.80, 0.36}), -- Barrier of Faith (absorbtion)
	},
	SHAMAN = {
		[61295]		= Aura(61295, nil, 'TOPRIGHT', {0.7, 0.3, 0.7}), -- Riptide
		[974]		= Aura(974, nil, 'BOTTOMRIGHT', {0.91, 0.80, 0.44}), -- Earth Shield
		[383648]	= Aura(383648, nil, 'BOTTOMRIGHT', {0.91, 0.80, 0.44}), -- Earth Shield (Elemental Orbit)
	},
	HUNTER = {
		[90361]		= Aura(90361, nil, 'TOP', {0.34, 0.47, 0.31}), -- Spirit Mend (HoT)
	},
	MONK = {
		[115175]	= Aura(115175, nil, 'TOP', {0.6, 0.9, 0.9}), -- Soothing Mist
		[116841]	= Aura(116841, nil, 'RIGHT', {0.12, 1.00, 0.53}), -- Tiger's Lust (Freedom)
		[116849]	= Aura(116849, nil, 'TOPRIGHT', {0.2, 0.8, 0.2}, true), -- Life Cocoon
		[119611]	= Aura(119611, nil, 'TOPLEFT', {0.3, 0.8, 0.6}), -- Renewing Mist
		[124682]	= Aura(124682, nil, 'BOTTOMLEFT', {0.8, 0.8, 0.25}), -- Enveloping Mist
		[191840]	= Aura(191840, nil, 'BOTTOMRIGHT', {0.27, 0.62, 0.7}), -- Essence Font
		[325209]	= Aura(325209, nil, 'BOTTOM', {0.3, 0.6, 0.6}), -- Enveloping Breath
	},
	PET = {
		-- Warlock Pets
		[193396]	= Aura(193396, nil, 'TOPRIGHT', {0.6, 0.2, 0.8}, true), -- Demonic Empowerment
		-- Hunter Pets
		[272790]	= Aura(272790, nil, 'TOPLEFT', {0.89, 0.09, 0.05}, true), -- Frenzy
		[136]		= Aura(136, nil, 'TOPRIGHT', {0.2, 0.8, 0.2}, true), -- Mend Pet
	},
}

-- List of spells to display ticks
G.unitframe.ChannelTicks = {
	-- Racials
	[291944]	= 6, -- Regeneratin (Zandalari)
	-- Evoker
	[356995]	= 3, -- Disintegrate
	-- Warlock
	[198590]	= 4, -- Drain Soul
	[755]		= 5, -- Health Funnel
	[234153]	= 5, -- Drain Life
	-- Priest
	[64843]		= 4, -- Divine Hymn
	[15407]		= 6, -- Mind Flay
	[48045]		= 6, -- Mind Sear
	[47757]		= 3, -- Penance (heal)
	[47758]		= 3, -- Penance (dps)
	[373129]	= 3, -- Penance (Dark Reprimand, dps)
	[400171]	= 3, -- Penance (Dark Reprimand, heal)
	[64902]		= 5, -- Symbol of Hope (Mana Hymn)
	-- Mage
	[5143]		= 4, -- Arcane Missiles
	[12051]		= 6, -- Evocation
	[205021]	= 5, -- Ray of Frost
	-- Druid
	[740]		= 4, -- Tranquility
	-- DK
	[206931]	= 3, -- Blooddrinker
	-- DH
	[198013]	= 10, -- Eye Beam
	[212084]	= 10, -- Fel Devastation
	-- Hunter
	[120360]	= 15, -- Barrage
	[257044]	= 7, -- Rapid Fire
	-- Monk
	[113656]	= 5, -- Fists of Fury
}

-- Spells that chain, second step
G.unitframe.ChainChannelTicks = {
	-- Evoker
	[356995]	= 4, -- Disintegrate
}

-- Window to chain time (in seconds); usually the channel duration
G.unitframe.ChainChannelTime = {
	-- Evoker
	[356995]	= 3, -- Disintegrate
}

-- Spells Effected By Talents (unused; talents changed)
G.unitframe.TalentChannelTicks = {
	-- TODO: going to change this to a method which allows for the following API checks
	-- IsSpellKnownOrOverridesKnown and/or IsPlayerSpell (for some spells, ex: Improved Purify)
}

-- Increase ticks from auras
G.unitframe.AuraChannelTicks = {
	-- Priest
	[47757]		= { filter = 'HELPFUL', spells = { [373183] = 6 } }, -- Harsh Discipline: Penance (heal)
	[47758]		= { filter = 'HELPFUL', spells = { [373183] = 6 } }, -- Harsh Discipline: Penance (dps)
}

-- Spells Effected By Haste, value is Base Tick Size
G.unitframe.HastedChannelTicks = {
	-- [spellID] = 1, -- SpellName
}

-- This should probably be the same as the whitelist filter + any personal class ones that may be important to watch
G.unitframe.AuraBarColors = {
	[2825]		= { enable = true, color = {r = 0.98, g = 0.57, b = 0.10 }}, -- [Shaman] Bloodlust
	[32182]		= { enable = true, color = {r = 0.98, g = 0.57, b = 0.10 }}, -- [Shaman] Heroism
	[80353]		= { enable = true, color = {r = 0.98, g = 0.57, b = 0.10 }}, -- [Mage] Time Warp
	[90355]		= { enable = true, color = {r = 0.98, g = 0.57, b = 0.10 }}, -- [Hunter] Ancient Hysteria
	[390386]	= { enable = true, color = {r = 0.99, g = 0.82, b = 0.24 }}, -- [Evoker] Fury of the Aspects
	[395296]	= { enable = true, color = {r = 0.98, g = 0.44, b = 0.00 }}, -- [Evoker] Ebon Might < self
	[395152]	= { enable = true, color = {r = 0.98, g = 0.44, b = 0.00 }}, -- [Evoker] Ebon Might < others
}

G.unitframe.AuraHighlightColors = {}

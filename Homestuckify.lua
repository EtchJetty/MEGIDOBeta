ModUtil.Mod.Register( "MEGIDOBeta" )

--!! Load Charater Textures

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package RoseArt.pkg"})
        LoadPackages({Name = {"RoseArt"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package JadeSprites.pkg"})
        LoadPackages({Name = {"JadeSprites"}})
        return baseFunc()
    end
)

--!! Set Colours

homestuckColors = {
	June = { 7, 21, 205, 255 },
	Rose = { 181, 54, 218, 255 },
	Dave = { 224, 7, 7, 255 },
	Jade = { 74, 201, 37, 255 },
	Jane = { 0, 213, 242, 255 },
	Jake = { 31, 148, 0, 255 },
	Roxy = { 241, 65, 239, 255 },
	Dirk = { 242, 164, 0, 255 },
	Vriska = { 0, 86, 130, 255 },
	Eridan = { 106, 0, 106, 255 },

	SpaceBg = { 0, 0, 0, 255 },
	SpaceAp = { 255, 255, 255, 255 },
	LightBg = { 247, 250, 78, 255 },
	LightAp = { 247, 250, 78, 255 },
	VoidBg = { 3, 52, 118, 255 },
	VoidAp = { 0, 19, 75, 255 },
	LifeBg = { 204, 195, 180, 255 },
	LifeAp = { 118, 195, 78, 255 },
	HopeBg = { 255, 224, 148, 255 },
	HopeAp = { 253, 253, 253, 255 },
	TimeBg = { 183, 13, 14, 255 },
	TimeAp = { 255, 35, 6, 255 },
	HeartBg = { 85, 20, 42, 255 },
	HeartAp = { 189, 24, 100, 255 },
	BreathBg = { 67, 121, 230, 255 },
	BreathAp = { 16, 223, 255, 255 },
	RageBg = { 67, 121, 230, 255 },
	RageAp = { 16, 223, 255, 255 },
}

--Format Lookup
homestuckLookup = {
	Aphrodite = "Roxy",
	Ares = "Dirk",
	Artemis = "Jane",
	Athena = "Rose",
	Chaos = "Eridan",
	Demeter = "Dave",
	Dionysus = "Jake",
	Hermes = "June",
	Poseidon = "Vriska",
	Zeus = "Jade"
}

homestuckGodKidPairs = { -- This doesn't include Jade, Eridan and Vriska since they have unique conditions
	June = "Breath",
	Rose = "Light",
	Dave = "Time",
	Jane = "Life",
	Jake = "Hope",
	Roxy = "Void",
	Dirk = "Heart",
}


--!! Add new Text formats for Charaters

local function addTextFormatting()

	-- Base text, change font and shit here
	baseFormatTable = {
		Font = "UbuntuMonoBold",
		FontSize = 27,
		Color = { 0, 0, 0, 255 },
		ShadowColor = Color.Black, 
		ShadowOffset = {2, 2}, 
		ShadowAlpha = 0.3,
		--OutlineColor = {0, 0, 0, 1.0},
		--OutlineThickness = 3.0,
	}

	-- Extra formats
	generatedFormatList = {
		CodexTitleFormat = {
			Font = "AlegreyaSansExtraBold",
			FontSize = 26,
			Color = Color.CodexText,
		},
	}

	-- Generate formats and merge to TextFormats table
	for homestuckKid,color in pairs(homestuckColors) do
		newFormat = {}

		for k,v in pairs(baseFormatTable) do
			newFormat[k] = v 
		end
		newFormat["Color"] = color

		generatedFormatList[homestuckKid] = newFormat
	end

	ModUtil.Table.Merge( TextFormats, generatedFormatList )

end

--!! Apply formatting to all Characters
-- Run this AFTER replacing all the text but BEFORE replacing the audio

local function applyFormattingDeep(topTable)

	-- Check if there are deeper tables
	local hasDeeperTable = false
	for k,v in pairs(topTable) do
		if type(v) == "table" then
			hasDeeperTable = true
			break
		end
	end

	if hasDeeperTable == true then

		-- Recursive function
		for k,v in pairs(topTable) do
			if type(v) == "table" then
				applyFormattingDeep(v)
			end
		end

	else

		-- Check if dialog line
		if topTable["Cue"] ~= nil and topTable["Text"] ~= nil then

			-- If VO is a god, give formatting
			godName = string.sub(topTable["Cue"], 5, -6)
			if homestuckLookup[godName] ~= nil then
				topTable["Text"] = "{#" .. homestuckLookup[godName] .. "}" .. topTable["Text"]
				topTable["Text"] = string.gsub(topTable["Text"], "{#PreviousFormat}", "{#PreviousFormat}{#" .. homestuckLookup[godName] .. "}")
			end

			-- Replace all refs of Hades Gods to Homestuck Gods
			for hadesGod,homeGod in pairs(homestuckLookup) do
				topTable["Text"] = string.gsub(topTable["Text"], hadesGod, homeGod)
			end

		end

	end

end

ModUtil.DebugCall( function()
	addTextFormatting()
	applyFormattingDeep(LootData)
	applyFormattingDeep(DeathLoopData) -- * This is really inefficent find the specific table later
	applyFormattingDeep(RoomSetData.Tartarus)
end )		



--!! Add Credits codex menu

table.insert(CodexOrdering.Order, "megido")
CodexOrdering.megido = {
	Order = {
		"Credits",
	}
}

Codex.megido = {
	UnlockType = CodexUnlockTypes.Mystery,
	TitleText = "MEGIDO",

	Entries = {
		Credits = {
			Entries = {
				{
					Text = "megidoCredits"
				},
				{
					Text = "megidoCredits",
					UnlockType = CodexUnlockTypes.Mystery,
					UnlockThreshold = 1,
				}
			}
		}
	}

}

--!! Change FX colours

newGodDmgVoiceColors = {
	ZeusDamageLight = homestuckColors.SpaceBg,
	ZeusDamage = homestuckColors.Jade,
	AthenaDamageLight = homestuckColors.LightBg,
	AthenaDamage = homestuckColors.LightAp,
	AphroditeDamageLight = homestuckColors.VoidBg,
	AphroditeDamage = homestuckColors.VoidAp,
	AresDamageLight = homestuckColors.LifeBg,
	AresDamage = homestuckColors.LifeAp,
	DionysusDamageLight = homestuckColors.HopeBg,
	DionysusDamage = homestuckColors.HopeAp,
	PoseidonDamageLight = homestuckColors.Vriska,
	PoseidonDamage = homestuckColors.Vriska,
	DemeterDamageLight = homestuckColors.TimeBg,
	DemeterDamage = homestuckColors.TimeAp,
	ArtemisDamageLight = homestuckColors.HeartBg,
	ArtemisDamage = homestuckColors.HeartAp,

	ZeusVoice = homestuckColors.Jade,
	PoseidonVoice = homestuckColors.Vriska,
	AthenaVoice = homestuckColors.Rose,
	AresVoice = homestuckColors.Jane,
	AphroditeVoice = homestuckColors.Roxy,
	ArtemisVoice = homestuckColors.Dirk,
	DionysusVoice = homestuckColors.Jake,
	DemeterVoice = homestuckColors.Dave,
	ChaosVoice = homestuckColors.Eridan
}

ModUtil.Table.Merge( Color, newGodDmgVoiceColors )

-- Load Loottable

function createColorSubLootData (Col1, Col2, Col3, Col4)
	return {
		Color = homestuckColors[Col1],
		LightingColor = homestuckColors[Col2],
		LootColor = homestuckColors[Col3],
		SubtitleColor = homestuckColors[Col4]
	}
end

function createAspectColorSubLootData (kidName, aspectName)
	return createColorSubLootData(kidName, aspectName .. "Ap", aspectName .. "Bg", kidName)
end

function createTextOnlyColorSubLootData (kidName)
	return createColorSubLootData(kidName, kidName, kidName, kidName)
end

ModUtil.DebugCall( function()
	ModUtil.Table.Merge( LootData.HermesUpgrade, createAspectColorSubLootData("June", "Breath") )
	ModUtil.Table.Merge( LootData.AthenaUpgrade, createAspectColorSubLootData("Rose", "Light") )
	ModUtil.Table.Merge( LootData.DemeterUpgrade, createAspectColorSubLootData("Dave", "Time") )
	ModUtil.Table.Merge( LootData.AresUpgrade, createAspectColorSubLootData("Jane", "Life") )
	ModUtil.Table.Merge( LootData.DionysusUpgrade, createAspectColorSubLootData("Jake", "Hope") )
	ModUtil.Table.Merge( LootData.AphroditeUpgrade, createAspectColorSubLootData("Roxy", "Void") )
	ModUtil.Table.Merge( LootData.ArtemisUpgrade, createAspectColorSubLootData("Dirk", "Heart") )
	ModUtil.Table.Merge( LootData.TrialUpgrade, createAspectColorSubLootData("Eridan", "Rage") )

	ModUtil.Table.Merge( LootData.ZeusUpgrade, createTextOnlyColorSubLootData("Jade") )
	ModUtil.Table.Merge( LootData.PoseidonUpgrade, createTextOnlyColorSubLootData("Vriska") )

	print(LootData.ZeusUpgrade.LightingColor[1])
end)


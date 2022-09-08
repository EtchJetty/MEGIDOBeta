ModUtil.Mod.Register( "MEGIDOBeta" )

--!! Settings

enableCustomDialogue = true


--!! Load Packages

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package BoonArt.pkg"})
        LoadPackages({Name = {"BoonArt"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package Portraits.pkg"})
        LoadPackages({Name = {"Portraits"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package LOTAK.pkg"})
        LoadPackages({Name = {"LOTAK"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package MenuElements.pkg"})
        LoadPackages({Name = {"MenuElements"}})
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
	Callie = { 146, 146, 146, 255 },

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


--!! Add new Text formats for Charaters

local function addTextFormatting()

	-- Base text, change font and shit here
	baseFormatTable = {
		Font = "FontStuckExtended",
		FontSize = 42,
		LineSpacingBottom = -15,
		Color = { 0, 0, 0, 255 },
		ShadowColor = Color.Black, 
		ShadowOffset = {0, 0}, 
		ShadowAlpha = 1.0,
		--ShadowOffset = {2, 2}, 
		--ShadowAlpha = 0.3,
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

addTextFormatting()

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
end)

--!! Enable custom dialogue and change formatting

-- Set Character Title and Name positions
LocalizationData.Narrative.SpeakerDisplayName = MergeTables({ 
	OffsetX = 110,
	OffsetY = -60,
}, LocalizationData.Narrative.SpeakerDisplayName )
LocalizationData.Narrative.SpeakerDescription = MergeTables({ 
	OffsetX = 110,
	OffsetY = -25,
}, LocalizationData.Narrative.SpeakerDescription )

local findAndReplace = {
	Zagreus = "Damara",
	Zag = "Dam",
	Z = "D",
	Prince = "Maiden",

	Thanatos = "Death",

	Tartarus = "LOTAK",
	Asphodel = "LOHAC",
	Elysium = "LOFAF",
	Styx = "LOCAH",
}

local baseDisplayTextLine = DisplayTextLine
function DisplayTextLine( screen, source, line, parentLine )

	if line.Text ~= nil and line.Cue ~= nil then
		-- Enable English Translations
		local text = line.Text
		if GetLanguage({}) == "en" then
			-- If the cue is defined, look up the translation without the '/VO/' prefix
			if line.Cue then
				local helpTextId = string.sub( line.Cue, 5 )
				text = helpTextId

				if HasDisplayName({ Text = helpTextId }) and enableCustomDialogue then
					text = GetDisplayName({ Text = text })
				else 
					text = line.Text -- Revert to default text
				end

			end
		end

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
			Zeus = "Jade",
			
			Dusa = "Callie",
		}

		-- Apply Formatting
		godName = string.sub(line.Cue, 5, -6)
		if homestuckLookup[godName] ~= nil then
			text = "{#" .. homestuckLookup[godName] .. "}" .. text
			text = string.gsub(text, "{#PreviousFormat}", "{#PreviousFormat}{#" .. homestuckLookup[godName] .. "}")
		else
			print(godName)
		end

		-- Replace God Names
		for hadesGod,homeGod in pairs(homestuckLookup) do
			text = string.gsub(text, hadesGod, homeGod)
		end

		-- Replace Words
		for find,replace in pairs(findAndReplace) do
			text = string.gsub(text, "([^%a])" .. find .. "([^%a])", "%1" .. replace .. "%2")
		end

		line.Text = text
	end

	line.TextOffsetX = -290
	line.TextOffsetY = 35

	baseDisplayTextLine( screen, source, line, parentLine )
end
findAndReplace = {
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

local homestuckLookup = {
  Aphrodite = "Jake",
  Ares = "Dirk",
  Artemis = "Jane",
  Athena = "Rose",
  Chaos = "Eridan",
  Demeter = "Dave",
  Dionysus = "Roxy",
  Hermes = "June",
  Poseidon = "Vriska",
  Zeus = "Jade",
  
  Dusa = "Callie",
	Hades = "Scratch",
	HadesField = "Scratch",
	Hypnos = "Megido",
	ZagreusField = "Megido",
	ZagreusHome = "Megido",
	Minotaur = "Gamzee",
	Theseus = "Karkat",
}

local usesNarratorTextbox = {
	"Achilles",
	"Eurydice",
	"Orpheus",
	"Patroclus",
	"Nyx",
	"Skelly",
	"MegaeraHome",
	"MegaeraField",
	"Alecto",
	"Tisiphone",
}

-- Set Character Title and Name positions for custom textbox

LocalizationData.Narrative.SpeakerDisplayName = MergeTables({ 
	OffsetX = 110,
	OffsetY = -60,
}, LocalizationData.Narrative.SpeakerDisplayName )
LocalizationData.Narrative.SpeakerDescription = MergeTables({ 
	OffsetX = 110,
	OffsetY = -25,
}, LocalizationData.Narrative.SpeakerDescription )


--!! Create Formatting

if createCustomTextFormats == true then

	-- Base text, change font and shit here
	baseFormatTable = {
		Font = "CourierNewBold",
		FontSize = 27,
		Color = Color.Black,

		ShadowColor = Color.DarkSlateGray, 
		ShadowOffset = {-2, -2}, 
		ShadowBlur = 0,
	}

	-- Extra formats
	generatedFormatList = {
		CodexTitleFormat = {
			Font = "AlegreyaSansExtraBold",
			FontSize = 26,
			Color = Color.CodexText,
		},
		Scratch = {
			Font = "CourierNewBold",
			FontSize = 27,
			Color = Color.White,
	
			ShadowColor = homestuckColors.Jade, 
			ShadowOffset = {-2, -2}, 
			ShadowBlur = 0,
		}
	}

	-- Generate formats and merge to TextFormats table
	for homestuckKid,color in pairs(homestuckColors) do
		newFormat = {}

		for k,v in pairs(baseFormatTable) do
			newFormat[k] = v 
		end
		
		local darkColor = {}
		for i,v in ipairs(color) do
			darkColor[i] = v / 2
			if darkColor[i] < 0 then darkColor[i] = 0 end
		end
		darkColor[4] = 255

		newFormat["Color"] = darkColor
		newFormat["ShadowColor"] = color

		generatedFormatList[homestuckKid] = newFormat
	end

	generatedFormatList["baseHomestuck"] = baseFormatTable

	ModUtil.Table.Merge( TextFormats, generatedFormatList )

end


--!! Enable custom dialogue and change formatting

local baseDisplayTextLine = DisplayTextLine
function DisplayTextLine( screen, source, line, parentLine )

	if line.Text ~= nil and line.Cue ~= nil then

    -- Custom Dialogue
		local text = line.Text
		if GetLanguage({}) == "en" then
			-- If the cue is defined, look up the translation without the '/VO/' prefix
			if line.Cue then
				local helpTextId = string.sub( line.Cue, 5 )
				text = helpTextId

				if HasDisplayName({ Text = helpTextId }) and doTranslations then
					text = GetDisplayName({ Text = text })
				else 
					text = line.Text -- Revert to default text
				end

			end
		end

		-- Apply Custom Formatting based on god
		godName = string.sub(line.Cue, 5, -6)
		godHomestuck = homestuckLookup[godName]

		if godHomestuck ~= nil then
			text = "{#" .. homestuckLookup[godName] .. "}" .. text
			text = string.gsub(text, "{#PreviousFormat}", "{#PreviousFormat}{#" .. homestuckLookup[godName] .. "}")
		else
			text = "{#baseHomestuck}" .. text
			text = string.gsub(text, "{#PreviousFormat}", "{#PreviousFormat}{#baseHomestuck}")
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

		-- Set text position
		line.TextOffsetX = -275
		line.TextOffsetY = 40

	end
	
	baseDisplayTextLine( screen, source, line, parentLine )
end
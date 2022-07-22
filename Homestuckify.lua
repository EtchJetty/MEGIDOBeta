ModUtil.Mod.Register( "MEGIDOBeta" )

-- Load Charater Textures

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

-- Add new Text formats for Charaters

local function addTextFormatting()

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
		Eridan = { 106, 0, 106, 255 }
	}

	-- Base text, change font and shit here
	baseFormatTable = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 0, 0, 0, 255 },
		ShadowColor = Color.Black, 
		ShadowOffset = {2, 2}, 
		ShadowAlpha = 0.3
	}

	-- Generate formats and merge to TextFormats table
	generatedFormatList = {}
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

-- Apply formatting to all Characters
-- Run this AFTER replacing all the text but BEFORE replacing the audio

local function applyFormattingDeep(topTable)

	--Format Lookup
	homestuckLookup = {
		Aphrodite = "Roxy",
		Ares = "Jane",
		Artemis = "Dirk",
		Athena = "Rose",
		Chaos = "Eridan",
		Demeter = "Dave",
		Dionysus = "Jake",
		Hermes = "June",
		Poseidon = "Vriska",
		Zeus = "Jade"
	}

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
			godName = string.sub(topTable["Cue"], 5, -6)
			if homestuckLookup[godName] ~= nil then
				topTable["Text"] = "{#" .. homestuckLookup[godName] .. "}" .. topTable["Text"]
				topTable["Text"] = string.gsub(topTable["Text"], "{#PreviousFormat}", "{#PreviousFormat}{#" .. homestuckLookup[godName] .. "}")
			end
		end

	end

end

ModUtil.DebugCall( function()
	addTextFormatting()
	applyFormattingDeep(LootData)
	applyFormattingDeep(RoomSetData.Tartarus)
end )		
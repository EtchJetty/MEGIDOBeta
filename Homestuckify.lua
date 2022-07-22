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

ModUtil.Table.Merge( TextFormats, {
	June = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 7, 21, 205, 255 }
	},
	Rose = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 181, 54, 218, 255 }
	},
	Dave = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 224, 7, 7, 255 }
	},
	Jade = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 74, 201, 37, 255 }
	},
	Jane = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 0, 213, 242, 255 }
	},
	Jake = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 31, 148, 0, 255 }
	},
	Roxy = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 241, 65, 239, 255 }
	},
	Dirk = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 242, 164, 0, 255 }
	},
	Vriska = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 0, 86, 130, 255 }
	},
	Eridan = {
		Font = "UbuntuMonoBold",
		FontSize = 28,
		Color = { 106, 0, 106, 255 }
	}
} )


-- Apply formatting to all Characters
-- Run this AFTER replacing all the text but BEFORE replacing the audio

local function applyFormattingDeep(topTable)

	--Format Lookup
	homestuckLookup = {
		Aphrodite = "Roxy",
		Arse = "Jane",
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
			end
		end

	end

end

ModUtil.DebugCall( function()
	applyFormattingDeep(LootData)
end )		

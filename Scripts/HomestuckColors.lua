-- Set Colours

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

newGodDmgVoiceColors = {
	ZeusDamageLight = homestuckColors.SpaceBg,
	ZeusDamage = homestuckColors.Jade,
	AthenaDamageLight = homestuckColors.LightBg,
	AthenaDamage = homestuckColors.LightAp,
	AphroditeDamageLight = homestuckColors.HopeBg,
	AphroditeDamage = homestuckColors.HopeAp,
	AresDamageLight = homestuckColors.LifeBg,
	AresDamage = homestuckColors.LifeAp,
	DionysusDamageLight = homestuckColors.VoidBg,
	DionysusDamage = homestuckColors.VoidAp,
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
	AphroditeVoice = homestuckColors.Jake,
	ArtemisVoice = homestuckColors.Dirk,
	DionysusVoice = homestuckColors.Roxy,
	DemeterVoice = homestuckColors.Dave,
	ChaosVoice = homestuckColors.Eridan
}

ModUtil.Table.Merge( Color, newGodDmgVoiceColors )

-- Load Loottable Colours

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
	ModUtil.Table.Merge( LootData.AphroditeUpgrade, createAspectColorSubLootData("Jake", "Hope") )
	ModUtil.Table.Merge( LootData.DionysusUpgrade, createAspectColorSubLootData("Roxy", "Void") )
	ModUtil.Table.Merge( LootData.ArtemisUpgrade, createAspectColorSubLootData("Dirk", "Heart") )
	ModUtil.Table.Merge( LootData.TrialUpgrade, createAspectColorSubLootData("Eridan", "Rage") )

	ModUtil.Table.Merge( LootData.ZeusUpgrade, createTextOnlyColorSubLootData("Jade") )
	ModUtil.Table.Merge( LootData.PoseidonUpgrade, createTextOnlyColorSubLootData("Vriska") )
end)
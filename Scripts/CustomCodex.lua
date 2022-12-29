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

--!! Add custom codex text
-- Zillyhoo

Codex.Items.Entries.WeaponUpgrade.Entries = {
	{
		UnlockThreshold = 1,
		Text = "CodexData_HS001",
	},
	{
		UnlockThreshold = 10,
		Text = "CodexData_HS002",
	},
	{
		UnlockThreshold = 25,
		Text = "CodexData_HS003",
	},
}
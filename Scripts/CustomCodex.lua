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
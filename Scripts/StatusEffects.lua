-- Dave slow effect
local baseChillApplyPresentation = ChillApplyPresentation
function ChillApplyPresentation( victim, victimId, chillStacks )

  local baseSetColor = SetColor
  local SetColor = function(args)
    args.Color = {
      homestuckColors.TimeAp[1] * chillStacks / 10, 
      homestuckColors.TimeAp[2] * chillStacks / 10, 
      homestuckColors.TimeAp[3] * chillStacks / 10,
      255
    }
    print("Vriska")
    baseSetColor(args)
  end

  baseChillApplyPresentation( victim, victimId, chillStacks )
end

local baseUpdateChillEffectStacks = UpdateChillEffectStacks
function UpdateChillEffectStacks( unit, unitId, stacks )

  local baseCreateTextBox = CreateTextBox
  local CreateTextBox = function(args)
    args.Color = Color.Lerp(homestuckColors.Dave, homestuckColors.TimeBg, (5 - stacks) / 5)
    if stacks >= 5 then 
      args.Color = Color.Lerp(homestuckColors.TimeBg, homestuckColors.TimeAp, (10 - stacks) / 5)
    end
    
    print("Vriska")
    baseCreateTextBox(args)
  end

  baseUpdateChillEffectStacks( unit, unitId, stacks )
end
-- Dave slow effect
ModUtil.Path.Context.Env("ChillApplyPresentation", function()

  ModUtil.Path.Wrap("SetColor", function(base, args)

    -- Get back chillStacks
    local newChillStacks = args.Color[1] / ( 8/10 )

    -- This is the same as homestuckColors.TimeAp
    -- Refrencing it directly seems to cause an error
    args.Color = {
      255 * newChillStacks / 10, 
      36 * newChillStacks / 10, 
      6 * newChillStacks / 10,
      255
    }
    return base(args)
  end, "MEGIDOBeta")

end)

-- Dave slow effect text color
ModUtil.Path.Context.Env("UpdateChillEffectStacks", function()

  ModUtil.Path.Wrap("CreateTextBox", function(base, args)

    args.Color = { 255, 35, 6, 255 }

    return base(args)
  end, "MEGIDOBeta")

end)
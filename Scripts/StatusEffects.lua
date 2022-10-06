-- Dave slow effect
ModUtil.Path.Context.Env("ChillApplyPresentation", function()

  ModUtil.Path.Wrap("SetColor", function(base, args)

    -- Get back chillStacks
    local newChillStacks = args.Color[1] / ( 8/10 )

    -- This is the same as homestuckColors.TimeAp
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
ModUtil.Path.Context.Env( "UpdateChillEffectStacks", function()

  Color = setmetatable({},{__index = Color})

  ModUtil.Path.Override( "Color.Lerp", function(args)
      return homestuckColors.Dave
  end, "MEGIDOBeta")

end )


-- Roxy hangover effect text color
ModUtil.Path.Context.Env( "UpdatePoisonEffectStacks", function()

  Color = setmetatable({},{__index = Color})

  ModUtil.Path.Override( "Color.Lerp", function(args)
      return homestuckColors.Roxy
  end, "MEGIDOBeta")

end )
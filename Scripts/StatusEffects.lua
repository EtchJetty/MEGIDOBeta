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
-- Again, refencing homestuckColors.TimeAp directly doesn't seem to work
local timeColor = { 255, 35, 6, 255 }

ModUtil.Path.Context.Env( "UpdateChillEffectStacks", function( )

  ModUtil.Path.Override( "Color.Lerp", function( )
      return timeColor
  end, MEGIDOBeta )

end )
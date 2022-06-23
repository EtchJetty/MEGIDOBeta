
local mod = "MEGIDOBeta"
ModUtil.RegisterMod(mod)
local package = "JadeSprites"

ModUtil.WrapBaseFunction( "SetupMap", function(baseFunc)
	DebugPrint({Text = "@"..mod.." Trying to load package "..package..".pkg"})
	LoadPackages({Name = {package}})
	return baseFunc()
end)

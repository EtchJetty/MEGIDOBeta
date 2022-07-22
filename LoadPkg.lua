local mod = "MEGIDOBeta"
ModUtil.RegisterMod(mod)
local package = "RoseArt"

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@" .. mod .. " Trying to load package " .. package .. ".pkg"})
        LoadPackages({Name = {package}})
        return baseFunc()
    end
)

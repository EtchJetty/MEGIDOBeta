ModUtil.Mod.Register( "MEGIDOBeta" )

--!! Settings

enableCustomDialogue = true
createCustomTextFormats = true

--!! Load Packages

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package BoonArt.pkg"})
        LoadPackages({Name = {"BoonArt"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package Portraits.pkg"})
        LoadPackages({Name = {"Portraits"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package LOTAK.pkg"})
        LoadPackages({Name = {"LOTAK"}})
        return baseFunc()
    end
)

ModUtil.WrapBaseFunction(
    "SetupMap",
    function(baseFunc)
        DebugPrint({Text = "@MEGIDOBeta Trying to load package MenuElements.pkg"})
        LoadPackages({Name = {"MenuElements"}})
        return baseFunc()
    end
)
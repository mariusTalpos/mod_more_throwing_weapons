::ModMoreThrowingWeapons <- {
	ID = "mod_more_throwing_weapons",
	Name = "More Throwing Weapons",
	Version = "1.0.0"
}

::ModMoreThrowingWeapons.HooksMod <- ::Hooks.register(::ModMoreThrowingWeapons.ID, ::ModMoreThrowingWeapons.Version, ::ModMoreThrowingWeapons.Name);
::ModMoreThrowingWeapons.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks >= 0.5.4", "mod_legends>= 19.0.0");
::ModMoreThrowingWeapons.HooksMod.queue(">mod_msu", ">mod_legends", function()
{
	::ModMoreThrowingWeapons.Mod <- ::MSU.Class.Mod(::ModMoreThrowingWeapons.ID, ::ModMoreThrowingWeapons.Version, ::ModMoreThrowingWeapons.Name);

    ::include("mod_more_throwing_weapons/load.nut");
}, ::Hooks.QueueBucket.Normal);
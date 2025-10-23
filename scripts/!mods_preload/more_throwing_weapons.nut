::MoreThrowingWeapons <- {
	ID = "more_throwing_weapons",
	Name = "MoreThrowingWeapons",
	Version = "1.0.0"
}
::mods_registerMod(::MoreThrowingWeapons.ID, ::MoreThrowingWeapons.Version, ::MoreThrowingWeapons.Name);

::mods_queue(::MoreThrowingWeapons.ID, null, function()
{
	::MoreThrowingWeapons.Mod <- ::MSU.Class.Mod(::MoreThrowingWeapons.ID, ::MoreThrowingWeapons.Version, ::MoreThrowingWeapons.Name);
	::mods_registerJS("./mods/MoreThrowingWeapons/index.js");
	::mods_registerCSS("./mods/MoreThrowingWeapons/index.css");
})
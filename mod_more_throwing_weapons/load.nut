foreach (file in ::IO.enumerateFiles("mod_more_throwing_weapons/config"))
{
	::include(file);
}

foreach (file in ::IO.enumerateFiles("mod_more_throwing_weapons/hooks"))
{
	::include(file);
}
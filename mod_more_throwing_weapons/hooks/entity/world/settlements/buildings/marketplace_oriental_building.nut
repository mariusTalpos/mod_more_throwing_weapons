::ModMoreThrowingWeapons.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_oriental_building", function(q)
{
	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 1,
				P = 1.0,
				S = "weapons/oriental/chakram_mainhand"
			},
			{
				R = 1,
				P = 1.0,
				S = "weapons/oriental/chakram_offhand"
			}
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}
});

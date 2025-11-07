::ModMoreThrowingWeapons.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_oriental_building", function(q)
{
	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 2,
				P = 1.0,
				S = "weapons/oriental/chakram"
			}
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}
});

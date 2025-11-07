::ModMoreThrowingWeapons.HooksMod.hook("scripts/skills/perks/perk_legend_ambidextrous", function(q)
{
	q.onEquip = @( __original ) function(_item)
	{
		m.ApplicableItems.push("weapon.chakram");

		__original( _item );
	}

	q.onUnequip = @( __original ) function(_item)
	{
		m.ApplicableItems.push("weapon.chakram");

		__original( _item );
	}
});

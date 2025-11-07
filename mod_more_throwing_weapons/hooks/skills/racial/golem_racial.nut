// ::ModMoreThrowingWeapons.HooksMod.hook("scripts/skills/racial/golem_racial", function( q ) {
// 	if (::mods_getRegisteredMod("mod_legends") != null)
// 	{
// 		q.onBeforeDamageReceived = @( __original ) function(_attacker, _skill, _hitInfo, _properties)
// 		{
// 			__original(_attacker, _skill, _hitInfo, _properties);
// 			if (_skill == null)
// 			{
// 				return;
// 			}

// 			if (_skill.getID() == "actives.throw_chakram")
// 			{
// 				_properties.DamageReceivedRegularMult *= 0.33;
// 			}
// 		}
// 	}
// });
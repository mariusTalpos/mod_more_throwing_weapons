::ModMoreThrowingWeapons.HooksMod.hook("scripts/skills/perks/perk_legend_ambidextrous", function(q)
{
	q.onEquip = @( __original ) function(_item)
	{
		// m.ApplicableItems.push("weapon.chakram_mainhand");
		m.ApplicableItems.push("weapon.chakram_offhand");

		__original( _item );
	}

	q.onUnequip = @( __original ) function(_item)
	{
		// m.ApplicableItems.push("weapon.chakram_mainhand");
		m.ApplicableItems.push("weapon.chakram_offhand");

		__original( _item );
	}

	q.onAnySkillExecuted = @( __original ) function(_skill, _targetTile, _targetEntity, _forFree)
	{
		if (!_skill.m.IsAttack)
			return; // Don't execute a follow up attack if the first skill is not an attack

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand) && this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null)
			return;// or if you are using hand to hand while the mainhand is holding a weapon

		local actor = this.getContainer().getActor();
		if (::Legends.S.skillEntityAliveCheck(actor, _targetEntity))
			return;

		// Check if using chakram - if so, skip distance check
		local items = actor.getItems();
		local mainhand = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local isUsingChakram = (offhand != null && (offhand.getID() == "weapon.chakram_offhand"));

		if (!isUsingChakram && actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1)
			return; // no gomu gomu h2h attacks (unless using chakram)

		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (_targetEntity != null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && (off == null || !::MSU.isNull(m.offHandSkill)))
		{
			if (!_forFree)
			{
				if (_targetTile == null || actor.getTile() == null) // Is this necessary?
					return;

				// i need to somehow do this more dynamically
				this.Const.SkillCounter++;
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), {
					TargetTile = _targetTile,
					Skill = !::MSU.isNull(m.offHandSkill) ? m.offHandSkill : m.HandToHand
				});
			}
		}
	}
});

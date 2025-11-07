this.chakram <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		PrimaryOffhandAttack = null,
		OffHandWeaponSkills = {},
		BleedSounds = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		]
	},

	function getPrimaryOffhandAttack() {
		return this.m.PrimaryOffhandAttack;
	}

	function isAmountShown() {
		return true;
	}

	function getAmountString() {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create() {
		this.weapon.create();
		this.m.ID = "weapon.chakram";
		this.m.Name = "Chakram";
		this.m.Description = "A circular metal disc with a sharpened outer edge. These deadly throwing weapons can slice through enemies and cause bleeding wounds.";
		this.m.Categories = "Throwing Weapon, One-Handed";
		this.m.IconLarge = "weapons/ranged/throwing_axes_01.png"; // TODO: Replace with chakram icon
		this.m.Icon = "weapons/ranged/throwing_axes_01_70x70.png"; // TODO: Replace with chakram icon
		this.m.SlotType = this.Const.ItemSlot.Mainhand | this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_thrown_01";
		this.m.Value = 180;
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		this.m.RangeMin = 1;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.4;
		this.m.DirectDamageMult = 0.2;
		this.m.ShieldDamage = 0;
		this.m.IsDroppedAsLoot = true;
	}

	function onEquip() {
		this.weapon.onEquip();
		local mainID = getContainer().getActor().getMainhandItem().m.ID;
		local offID = getContainer().getActor().getOffhandItem().m.ID;

		local container = ::Legends.Actives.getContainer(this, "weapon.chakram");
		local hasSkill = container.hasSkill("actives.throw_chakram");
		local hasOffhandSkill = container.hasSkill("actives.throw_chakram_offhand");

		if (mainID == this.m.ID && !hasSkill){
			this.addSkill(this.new("scripts/skills/actives/throw_chakram"));
		}

		if (offID == this.m.ID && !hasOffhandSkill){
			m.OffHandWeaponSkills.clear(); // reset, it isn't bad for being too careful

			local skill = null;
			skill = ::new("scripts/skills/actives/throw_chakram");
			// Create offhand version of the skill
			this.m.OffHandWeaponSkills[skill.m.ID] <- ::MSU.asWeakTableRef(skill);
			this.m.PrimaryOffhandAttack = this.m.OffHandWeaponSkills[skill.m.ID];
			skill.m.Order = ::Const.SkillOrder.UtilityTargeted - 3;
			skill.m.ID = skill.m.ID + "_offhand";
			// actives by default should be tied to items if _target is an item
			if (::MSU.isKindOf(this, "item")) {
				if (!hasSkill) {
					this.addSkill(skill);
				}
			} else {
				container.add(skill);
			}
		}

	}

	function setAmmo(_a) {
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0) {
			this.m.Name = "Chakram";
			this.m.IconLarge = "weapons/ranged/throwing_axes_01.png"; // TODO: Replace with chakram icon
			this.m.Icon = "weapons/ranged/throwing_axes_01_70x70.png"; // TODO: Replace with chakram icon
			this.m.ShowArmamentIcon = true;
		} else {
			this.m.Name = "Chakram (Empty)";
			this.m.IconLarge = "weapons/ranged/throwing_axes_01_bag.png"; // TODO: Replace with chakram icon
			this.m.Icon = "weapons/ranged/throwing_axes_01_bag_70x70.png"; // TODO: Replace with chakram icon
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

	function onDamageDealt(_target, _skill, _hitInfo) {
		::logDebug("Chakram onDamageDealt called");
		if (!_target.isAlive() || _target.isDying()) {
			if (this.isKindOf(_target, "lindwurm_tail") || !_target.getCurrentProperties().IsImmuneToBleeding) {
				::logDebug("Target is immune to bleed");
				this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		} else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding) {
			::logDebug("Chakram applied bleeding effect");
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			_target.getSkills().add(effect);
			this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
		}
	}

	// function onUpdateProperties( _properties )
	// {
	// 	local main = getContainer().getActor().getMainhandItem();

	// 	weapon.onUpdateProperties(_properties);

	// 	local shouldHidden = main.m.RegularDamageMax >= m.RegularDamageMax;
	// 	foreach (id, offhandSkill in m.OffHandWeaponSkills)
	// 	{
	// 		local mainhandSkill = getContainer().getActor().getSkills().getSkillByID(id);

	// 		if (mainhandSkill == null) {
	// 			if (offhandSkill != null && "m" in offhandSkill) {
	// 				offhandSkill.m.IsHidden = false;
	// 			}
	// 			continue;
	// 		} else if (::MSU.isNull(offhandSkill)) {
	// 			if (mainhandSkill != null && "m" in mainhandSkill) {
	// 				mainhandSkill.m.IsHidden = false;
	// 			}
	// 			continue;
	// 		}

	// 		offhandSkill.m.IsHidden = shouldHidden;
	// 		mainhandSkill.m.IsHidden = !shouldHidden;
	// 	}
	// }

});
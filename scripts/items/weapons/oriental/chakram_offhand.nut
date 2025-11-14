this.chakram_offhand <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		PrimaryOffhandAttack = null,
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
		this.m.ID = "weapon.chakram_offhand";
		this.m.Name = "Chakram (Offhand)";
		this.m.Description = "A circular metal disc with a sharpened outer edge. These deadly throwing weapons can slice through enemies and cause bleeding wounds.";
		this.m.Categories = "Throwing Weapon, One-Handed";
		this.m.IconLarge = "weapons/ranged/chakram.png"; // TODO: Replace with chakram icon
		this.m.Icon = "weapons/ranged/chakram_70x70.png"; // TODO: Replace with chakram icon
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_chakram_01";
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
		local offID = getContainer().getActor().getOffhandItem().m.ID;

		local container = ::Legends.Actives.getContainer(this, "weapon.chakram_offhand");
		local hasOffhandSkill = container.hasSkill("actives.throw_chakram_offhand");

		if (offID == this.m.ID && !hasOffhandSkill){

			local skill = null;
			skill = ::new("scripts/skills/actives/throw_chakram_offhand");
			// Create offhand version of the skill
			this.m.PrimaryOffhandAttack = skill;
			skill.m.Order = ::Const.SkillOrder.UtilityTargeted - 3;
			// actives by default should be tied to items if _target is an item
			if (::MSU.isKindOf(this, "item")) {
				if (!hasOffhandSkill) {
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
			this.m.IconLarge = "weapons/ranged/chakram.png";
			this.m.Icon = "weapons/ranged/chakram_70x70.png";
			this.m.ShowArmamentIcon = true;
		} else {
			this.m.Name = "Chakram (Empty)";
			this.m.IconLarge = "weapons/ranged/chakram.png";
			this.m.Icon = "weapons/ranged/chakram_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

	function onDamageDealt(_target, _skill, _hitInfo) {
		if (!_target.isAlive() || _target.isDying()) {
			if (this.isKindOf(_target, "lindwurm_tail") || !_target.getCurrentProperties().IsImmuneToBleeding) {
				this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		} else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding) {
			local offID = getContainer().getActor().getOffhandItem().m.ID;
			if (_skill.ClassName == "throw_chakram_offhand") {
				::logDebug("Chakram applied offhand bleeding effect");
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				_target.getSkills().add(effect);
				this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}

});
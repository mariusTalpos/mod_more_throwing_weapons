this.biglatl <- this.inherit("scripts/items/weapons/weapon", {
	m = {},

	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.biglatl";
		this.m.Name = "Two-Handed Atlatl and Darts";
		this.m.Description = "A larger, two-handed spear-thrower for launching light darts. Functions like bundled throwing spears.";
		this.m.Categories = "Throwing Weapon, Two-Handed";
		this.m.IconLarge = "weapons/ranged/javelins_01.png"; // TODO: Replace with big atlatl icon
		this.m.Icon = "weapons/ranged/javelins_01_70x70.png"; // TODO: Replace with big atlatl icon
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_javelin_02";
		this.m.IsTwoHanded = true; // two-handed atlatl
		this.m.Value = 200;
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
		this.m.RangeMin = 1;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.45;
		this.m.ShieldDamage = 0;
		this.m.IsDroppedAsLoot = true;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		// Reuse javelin throw for now
		this.addSkill(this.new("scripts/skills/actives/throw_javelin"));
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Two-Handed Atlatl and Darts";
			this.m.IconLarge = "weapons/ranged/javelins_01.png"; // TODO: Replace with big atlatl icon
			this.m.Icon = "weapons/ranged/javelins_01_70x70.png"; // TODO: Replace with big atlatl icon
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Two-Handed Atlatl and Darts (Empty)";
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png"; // TODO: Replace with big atlatl icon
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png"; // TODO: Replace with big atlatl icon
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

});
